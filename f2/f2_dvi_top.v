// F2 (TASK-6069): DVI testna slika na ULX5M-GS kroz sloj platforme.
//   clk_nes  : upisivac u NES ritmu (341 x 262, piksel svaki 2. takt) -> framebuffer u vga.v
//   clk_pixel: NES-ov vga.v (640x480@60, 2x skaliranje, prozor 65..575) -> gm_dvi
//   clk_shift: gm_dvi_phy (CC_ODDR 5x DDR, CC_LVDS_OBUF)
// Isti put kao u F4 (PPU pise framebuffer u clk_nes), samo je PPU zamijenjen f2_testpat.
// LED (aktivne u 0): 0 = lock PLL1, 1 = lock PLL2, 2 = okviri VGA (bit 5), 3 = okviri NES (bit 5).
module f2_dvi_top #(
  parameter [0:0] CLK_SERIAL = 1'b0
) (
  input        clk_25mhz,
  output [7:0] led,
  output [3:0] gpdi_dp,
  output [3:0] gpdi_dn
);
  wire clk_shift, rst_shift, clk_pixel, rst_pixel, clk_usb, rst_usb, clk_nes, rst_nes;
  wire locked_video, locked_nes, sdram_clk;
  gm_clocks u_clk (
    .clk25(clk_25mhz), .rst_i(1'b0),
    .clk_shift(clk_shift), .rst_shift(rst_shift), .clk_pixel(clk_pixel), .rst_pixel(rst_pixel),
    .clk_usb(clk_usb), .rst_usb(rst_usb), .clk_nes(clk_nes), .rst_nes(rst_nes),
    .locked_video(locked_video), .locked_nes(locked_nes), .sdram_clk(sdram_clk));

  // ---- upisivac (zamjena za PPU): cycle/scanline kao NES ----
  reg       ph = 1'b0;
  reg [8:0] cycle = 9'd0, scanline = 9'd0;
  reg [5:0] nes_frames = 6'd0;
  always @(posedge clk_nes) begin
    if (rst_nes) begin
      ph <= 1'b0; cycle <= 9'd0; scanline <= 9'd0;
    end else begin
      ph <= ~ph;
      if (ph) begin
        if (cycle == 9'd340) begin
          cycle <= 9'd0;
          if (scanline == 9'd261) begin scanline <= 9'd0; nes_frames <= nes_frames + 1'b1; end
          else scanline <= scanline + 1'b1;
        end else cycle <= cycle + 1'b1;
      end
    end
  end
  wire [5:0] color;
  f2_testpat u_pat (.x(cycle), .y(scanline), .color(color));

  wire       vga_hs, vga_vs, vga_blank;
  wire [7:0] r, g, b;
  vga vga_i (
    .I_CLK(clk_nes), .I_CLK_VGA(clk_pixel), .I_COLOR(color), .I_HCNT(cycle), .I_VCNT(scanline),
    .O_HSYNC(vga_hs), .O_VSYNC(vga_vs), .O_BLANK(vga_blank), .O_RED(r), .O_GREEN(g), .O_BLUE(b));

  gm_dvi #(.CLK_SERIAL(CLK_SERIAL)) u_dvi (
    .clk_pixel(clk_pixel), .clk_shift(clk_shift),
    .red(r), .green(g), .blue(b), .hsync(vga_hs), .vsync(vga_vs), .blank(vga_blank),
    .gpdi_dp(gpdi_dp), .gpdi_dn(gpdi_dn));

  reg vs_d = 1'b1;
  reg [5:0] vga_frames = 6'd0;
  always @(posedge clk_pixel) begin
    vs_d <= vga_vs;
    if (vs_d & ~vga_vs) vga_frames <= vga_frames + 1'b1;
  end
  assign led = ~{4'b0000, nes_frames[5], vga_frames[5], locked_nes, locked_video};
endmodule
