// VGA -> DVI za ULX5M-GS (F2, TASK-6069): ulazni registar + 3 x gm_tmds_enc (protocni,
// domena piksela) + gm_dvi_phy (125 MHz, CC_ODDR). Ulazi su izlazi NES-ovog vga.v
// (kombinacijski iza palete, blank = ~de); hsync/vsync idu kao C0/C1 plavog kanala
// (kao vga2dvid.v). Latencija 1 + 3 takta piksela, jednaka za sve signale.
module gm_dvi #(
  parameter [0:0] CLK_SERIAL = 1'b0
) (
  input        clk_pixel,
  input        clk_shift,
  input  [7:0] red, green, blue,
  input        hsync, vsync, blank,
  output [3:0] gpdi_dp,
  output [3:0] gpdi_dn
);
  reg [7:0] r_q = 8'd0, g_q = 8'd0, b_q = 8'd0;
  reg       hs_q = 1'b1, vs_q = 1'b1, de_q = 1'b0;
  always @(posedge clk_pixel) begin
    r_q <= red; g_q <= green; b_q <= blue;
    hs_q <= hsync; vs_q <= vsync; de_q <= ~blank;
  end
  wire [9:0] q_r, q_g, q_b;
  gm_tmds_enc u_enc_b (.clk(clk_pixel), .d(b_q), .c({vs_q, hs_q}), .de(de_q), .q(q_b));
  gm_tmds_enc u_enc_g (.clk(clk_pixel), .d(g_q), .c(2'b00),        .de(de_q), .q(q_g));
  gm_tmds_enc u_enc_r (.clk(clk_pixel), .d(r_q), .c(2'b00),        .de(de_q), .q(q_r));
  gm_dvi_phy #(.CLK_SERIAL(CLK_SERIAL)) u_phy (
    .clk_pixel(clk_pixel), .clk_shift(clk_shift),
    .d_blue(q_b), .d_green(q_g), .d_red(q_r), .dp(gpdi_dp), .dn(gpdi_dn));
endmodule
