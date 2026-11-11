// F3 vrata 2 (TASK-6070): NES CPU (t65) + 2 KB RAM + nestest PRG (NROM) u BRAM-u na ULX5M-GS.
// Sve u domeni clk_nes 10,714 MHz (gm_clocks, PLL2); CPU enable /6 (opcija C) = 1,786 MHz.
// Petlja: reset CPU-a -> nestest od $C000 do povratka na $0001 (≈ 15 ms) -> stanje se zamrzne ->
// na sljedecu sekundu jedan redak na UART (115200 8N1, hex) -> ponovno od reseta.
//   F3 T=<run> N=<instrukcija> C=<CPU ciklusa> PC=<zadnji PC> A= X= Y= P= S= R=<$02$03> H=<CRC32> E=<kraj> I=<AXYPS>
// H = CRC-32 (zlib) traga po instrukciji, bajtovi PCH PCL A X Y P&EF S -- isti racun radi
// f3/cmp_trace.py nad simulacijom i nad nestest.log. E: 1 = kraj na $0001, 2 = isteklo (> MAXN).
// I = A X Y P S prvog retka traga ($C000) = stanje CPU-a nakon reseta.
// LED (aktivne u 0): 0 = clk_nes (bit 23), 1 = E=1, 2 = R=0000 (nestest PASS), 3 = CRC = referenca,
//   4 = lock PLL2, 7 = bljesak po retku.
module f3_top #(
  parameter integer BAUD_DIV = 93,          // 10 714 286 / 115200 = 93,0 (+0,006 %)
  parameter integer SEC      = 10714286,    // taktova clk_nes po retku
  parameter [31:0]  H_REF    = 32'hD4D52E3B,// CRC nestest.log (f3/cmp_trace.py)
  parameter         PRG_HEX  = "f3/nestest_prg.hex",
  parameter integer MAXN     = 20000
) (
  input        clk_25mhz,
  input  [2:0] btn,
  output [7:0] led,
  output       uart_tx,
  output       uart_tx2,
  output       sdram_clk
);
  wire clk_nes, rst_nes, locked_nes;
  gm_clocks u_clk (
    .clk25(clk_25mhz), .rst_i(1'b0),
    .clk_shift(), .rst_shift(), .clk_pixel(), .rst_pixel(), .clk_usb(), .rst_usb(),
    .clk_nes(clk_nes), .rst_nes(rst_nes),
    .locked_video(), .locked_nes(locked_nes), .sdram_clk(sdram_clk));

  // ---- CPU sustav ----
  reg  cpu_rst = 1'b1, run = 1'b0;
  wire tr_valid; wire [15:0] tr_pc; wire [7:0] ta, tx_, ty, tp, ts, r02, r03; wire [31:0] tcyc;
  f3_cpu_sys #(.DIV_CPU(6), .PRG_HEX(PRG_HEX)) u_sys (
    .clk(clk_nes), .rst(cpu_rst), .run(run), .cpu_ce(), .addr(), .rnw(), .dout(), .din(),
    .tr_valid(tr_valid), .tr_pc(tr_pc), .tr_a(ta), .tr_x(tx_), .tr_y(ty), .tr_p(tp), .tr_s(ts),
    .tr_cyc(tcyc), .r02(r02), .r03(r03));

  // ---- CRC-32 traga, bajt po takt (instrukcija traje >= 2 CPU ciklusa = 12 taktova > 7) ----
  reg [31:0] crc = 32'hFFFFFFFF;
  reg [55:0] rec = 0;
  reg [2:0]  nb = 0;
  function [31:0] crc8(input [31:0] c, input [7:0] d);
    integer i; reg [31:0] r;
    begin
      r = c ^ {24'd0, d};
      for (i = 0; i < 8; i = i + 1) r = r[0] ? (r >> 1) ^ 32'hEDB88320 : (r >> 1);
      crc8 = r;
    end
  endfunction

  // ---- upravljanje: reset -> rad -> kraj -> cekaj sekundu -> ispis -> ponovo ----
  localparam S_RST = 2'd0, S_RUN = 2'd1, S_DONE = 2'd2;
  reg [1:0]  st = S_RST;
  reg [4:0]  rcnt = 0;
  reg [15:0] n = 0, runs = 0;
  reg [3:0]  ecode = 0;
  reg [23:0] sec = 0;
  reg        tick = 1'b0;
  reg [203:0] snap = 0;           // 51 nibble, redom kao '@' u predlosku
  reg [39:0]  first = 0;          // prvi zapis traga (A X Y P S na $C000) = pocetno stanje CPU-a
  reg        pass_ok = 1'b0, crc_ok = 1'b0, end_ok = 1'b0;
  wire [31:0] hfin = ~crc;

  always @(posedge clk_nes) begin
    tick <= 1'b0;
    sec  <= (sec == SEC - 1) ? 24'd0 : sec + 1'b1;
    if (nb != 0) begin crc <= crc8(crc, rec[55:48]); rec <= {rec[47:0], 8'h00}; nb <= nb - 1'b1; end
    if (rst_nes) begin
      st <= S_RST; rcnt <= 0; cpu_rst <= 1'b1; run <= 1'b0; runs <= 0;
    end else case (st)
      S_RST: begin
        cpu_rst <= 1'b1; run <= 1'b0; n <= 0; crc <= 32'hFFFFFFFF; nb <= 0;
        rcnt <= rcnt + 1'b1;
        if (rcnt == 5'd31) begin cpu_rst <= 1'b0; run <= 1'b1; st <= S_RUN; end
      end
      S_RUN: if (tr_valid) begin
        if (tr_pc == 16'h0001 || n == MAXN) begin
          run <= 1'b0; st <= S_DONE; ecode <= (tr_pc == 16'h0001) ? 4'd1 : 4'd2;
        end else begin
          n <= n + 1'b1; rec <= {tr_pc, ta, tx_, ty, tp & 8'hEF, ts}; nb <= 3'd7;
          if (n == 0) first <= {ta, tx_, ty, tp, ts};
        end
      end
      S_DONE: if (sec == SEC - 1 && nb == 0) begin
        runs <= runs + 1'b1; tick <= 1'b1;
        snap <= {runs + 16'd1, n, tcyc[23:0], tr_pc, ta, tx_, ty, tp, ts, r02, r03, hfin, ecode, first};
        end_ok <= (ecode == 4'd1); pass_ok <= ({r02, r03} == 16'h0000); crc_ok <= (hfin == H_REF);
        st <= S_RST; rcnt <= 0;
      end
      default: st <= S_RST;
    endcase
  end

  // ---- ispis retka: '@' = sljedeci nibble snimke (hex) ----
  localparam integer L = 95;
  localparam [8*L-1:0] TPL = "F3 T=@@@@ N=@@@@ C=@@@@@@ PC=@@@@ A=@@ X=@@ Y=@@ P=@@ S=@@ R=@@@@ H=@@@@@@@@ E=@ I=@@@@@@@@@@\015\012";
  reg [6:0]   pos = 0;
  reg         busy = 1'b0, ustart = 1'b0;
  reg [7:0]   ubyte = 0;
  reg [203:0] sh = 0;
  reg [22:0]  blink = 0;
  wire        uready;
  wire [7:0]  ch = TPL[8*(L-1-pos) +: 8];
  wire [3:0]  nib = sh[203:200];
  always @(posedge clk_nes) begin
    ustart <= 1'b0;
    if (blink != 0) blink <= blink - 1'b1;
    if (!busy) begin
      if (tick) begin busy <= 1'b1; pos <= 0; sh <= snap; blink <= 23'h7fffff; end
    end else if (uready && !ustart) begin
      ustart <= 1'b1; pos <= pos + 1'b1;
      if (ch == "@") begin ubyte <= (nib < 10) ? "0" + nib : "A" - 10 + nib; sh <= {sh[199:0], 4'h0}; end
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
  assign led = ~{blink != 0, 2'b00, locked_nes, crc_ok, pass_ok, end_ok, hb[23]};
endmodule
