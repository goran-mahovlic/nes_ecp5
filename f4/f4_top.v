// F4 (TASK-6071): cijeli NES (f4_nes_sys: t65 + PPU + APU bez zvuka + NROM u BRAM-u) na ULX5M-GS.
//   clk_nes  10,714 MHz: NES (CPU /6, PPU /2 = opcija C) + f4_frame_crc + UART 115200
//   clk_pixel 25 MHz   : vga.v (framebuffer 256x240 -> 640x480, 2x) -> gm_dvi
//   clk_shift 125 MHz  : gm_dvi_phy (CC_ODDR, CC_LVDS_OBUF) -- isti put kao F2
// Tipke GS-a (BTN1..3, PULLUP, pritisnuto = 0): btn[0] = Start, btn[1] = A, btn[2] = Select.
// UART jednom u sekundi (redak fiksne duljine, hex):
//   F4 T=<redak> F=<kadar od reseta> H=<CRC kadra REF_FRAME> G=<CRC zadnjeg kadra> N=<piksela zadnjeg>
//      PC=<zadnji dohvat opkoda> V=<zadnji upis u $0701> I=<NMI u sekundi> K=<btn sirovo>
// CRC = f4_frame_crc (isti modul kao sim/f4/tb_f4_frame.v) -> H mora biti jednak CRC-u istog kadra iz simulacije.
// LED (aktivne u 0): 0 = takt NES (bit 23), 1 = kadar (bit 5), 2 = H == H_REF, 3 = N == 61440,
//   4 = lock PLL1, 5 = lock PLL2, 7 = bljesak po retku.
module f4_top #(
  parameter integer BAUD_DIV  = 93,          // 10 714 286 / 115200 (+0,006 %), kao F3
  parameter integer SEC       = 10714286,
  parameter integer REF_FRAME = 120,
  parameter [31:0]  H_REF     = 32'h63937DA4,// sim/f4: KADAR 120 (Super Tilt Bro, bez tipki)
  parameter         PRG_HEX   = "f4/tilt_prg.hex",
  parameter         CHR_HEX   = "f4/tilt_chr.hex",
  parameter integer PRG_AW    = 15,
  parameter [31:0]  FLAGS     = 32'h00000100
) (
  input        clk_25mhz,
  input  [2:0] btn,
  output [7:0] led,
  output       uart_tx,
  output       uart_tx2,
  output [3:0] gpdi_dp,
  output [3:0] gpdi_dn
);
  wire clk_shift, rst_shift, clk_pixel, rst_pixel, clk_nes, rst_nes, locked_video, locked_nes;
  gm_clocks u_clk (
    .clk25(clk_25mhz), .rst_i(1'b0),
    .clk_shift(clk_shift), .rst_shift(rst_shift), .clk_pixel(clk_pixel), .rst_pixel(rst_pixel),
    .clk_usb(), .rst_usb(), .clk_nes(clk_nes), .rst_nes(rst_nes),
    .locked_video(locked_video), .locked_nes(locked_nes), .sdram_clk());

  // ---- reset NES-a: rst_nes + 32 takta (kao F3) ----
  reg [4:0] rcnt = 0;
  reg       nes_rst = 1'b1;
  always @(posedge clk_nes)
    if (rst_nes) begin rcnt <= 0; nes_rst <= 1'b1; end
    else if (rcnt != 5'd31) rcnt <= rcnt + 1'b1;
    else nes_rst <= 1'b0;

  // ---- tipke: sinkronizator, aktivne u 0 -> {Right, Left, Down, Up, Start, Select, B, A} ----
  reg [2:0] b1 = 3'b111, b2 = 3'b111;
  always @(posedge clk_nes) begin b1 <= btn; b2 <= b1; end
  wire [7:0] buttons = {4'b0000, ~b2[0], ~b2[2], 1'b0, ~b2[1]};

  wire [5:0] color; wire [8:0] cycle, scanline;
  wire [21:0] la; wire cwr; wire [7:0] cwd; wire [15:0] pc; wire nmi;
  f4_nes_sys #(.PRG_HEX(PRG_HEX), .CHR_HEX(CHR_HEX), .PRG_AW(PRG_AW), .MAPPER_FLAGS(FLAGS)) u_nes (
    .clk(clk_nes), .reset(nes_rst), .buttons(buttons), .color(color), .cycle(cycle), .scanline(scanline),
    .cpu_ce(), .cpu_laddr(la), .cpu_wr(cwr), .cpu_wdata(cwd), .cpu_pc(pc), .cpu_nmi(nmi));

  // ---- slika: isto kao F2 ----
  wire vga_hs, vga_vs, vga_blank; wire [7:0] r, g, b;
  vga vga_i (
    .I_CLK(clk_nes), .I_CLK_VGA(clk_pixel), .I_COLOR(color), .I_HCNT(cycle), .I_VCNT(scanline),
    .O_HSYNC(vga_hs), .O_VSYNC(vga_vs), .O_BLANK(vga_blank), .O_RED(r), .O_GREEN(g), .O_BLUE(b));
  gm_dvi u_dvi (
    .clk_pixel(clk_pixel), .clk_shift(clk_shift),
    .red(r), .green(g), .blue(b), .hsync(vga_hs), .vsync(vga_vs), .blank(vga_blank),
    .gpdi_dp(gpdi_dp), .gpdi_dn(gpdi_dn));

  // ---- provjera kadra: CRC kao u simulaciji ----
  wire fd; wire [31:0] fcrc; wire [16:0] fpix;
  f4_frame_crc u_crc (.clk(clk_nes), .color(color), .cycle(cycle), .scanline(scanline),
    .pix_valid(), .pix_x(), .pix_y(), .pix_c(), .frame_done(fd), .frame_crc(fcrc), .frame_pix(fpix));

  reg [15:0] frames = 0, lines = 0;
  reg [31:0] h_ref = 0, g_last = 0;
  reg [16:0] n_last = 0;
  reg [7:0]  v0701 = 0, nmis = 0;
  reg        nmi_d = 1'b0;
  reg [23:0] sec = 0;
  reg        tick = 1'b0;
  reg [151:0] snap = 0;           // 38 nibblova, redom kao '@' u predlosku
  always @(posedge clk_nes) begin
    tick <= 1'b0;
    nmi_d <= nmi;
    if (nes_rst) begin
      frames <= 0; h_ref <= 0; v0701 <= 0;
    end else begin
      if (fd) begin
        frames <= frames + 1'b1; g_last <= fcrc; n_last <= fpix;
        if (frames + 1'b1 == REF_FRAME) h_ref <= fcrc;
      end
      if (cwr && la == {11'b11_1000_0000_0, 11'h701}) v0701 <= cwd;
    end
    if (nmi && !nmi_d) nmis <= nmis + 1'b1;
    if (sec == SEC - 1) begin
      sec <= 0; tick <= 1'b1; lines <= lines + 1'b1; nmis <= 0;
      snap <= {lines + 16'd1, frames, h_ref, g_last, 3'b000, n_last, pc, v0701, nmis, 1'b0, b2};
    end else sec <= sec + 1'b1;
  end

  // ---- ispis retka: '@' = sljedeci nibble snimke (hex), kao f3_top ----
  localparam integer L = 70;
  localparam [8*L-1:0] TPL = "F4 T=@@@@ F=@@@@ H=@@@@@@@@ G=@@@@@@@@ N=@@@@@ PC=@@@@ V=@@ I=@@ K=@\015\012";
  reg [6:0]   pos = 0;
  reg         busy = 1'b0, ustart = 1'b0;
  reg [7:0]   ubyte = 0;
  reg [151:0] sh = 0;
  reg [22:0]  blink = 0;
  wire        uready;
  wire [7:0]  ch = TPL[8*(L-1-pos) +: 8];
  wire [3:0]  nib = sh[151:148];
  always @(posedge clk_nes) begin
    ustart <= 1'b0;
    if (blink != 0) blink <= blink - 1'b1;
    if (!busy) begin
      if (tick) begin busy <= 1'b1; pos <= 0; sh <= snap; blink <= 23'h7fffff; end
    end else if (uready && !ustart) begin
      ustart <= 1'b1; pos <= pos + 1'b1;
      if (ch == "@") begin ubyte <= (nib < 10) ? "0" + nib : "A" - 10 + nib; sh <= {sh[147:0], 4'h0}; end
      else ubyte <= ch;
      if (pos == L - 1) busy <= 1'b0;
    end
  end
  wire txw;
  f1_uart_tx #(.DIV(BAUD_DIV)) u_tx (.clk(clk_nes), .start(ustart), .data(ubyte), .ready(uready), .tx(txw));
  assign uart_tx = txw;
  assign uart_tx2 = txw;

  reg [23:0] hb = 0;
  always @(posedge clk_nes) hb <= hb + 1'b1;
  assign led = ~{blink != 0, 1'b0, locked_nes, locked_video, n_last == 17'd61440, h_ref == H_REF, frames[5], hb[23]};
endmodule
