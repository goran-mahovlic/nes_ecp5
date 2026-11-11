// DVI PHY za ULX5M-GS (F2, TASK-6069): 10:1 serijalizacija na clk_shift (125 MHz) kroz
// CC_ODDR (2 bita po taktu) + CC_LVDS_OBUF. Doslovni port LiteX_DVI
// gateware/video_colognechip_hdmi_phy.py, serializer_mode="custom" (radi na GS-u):
//   - u domeni piksela preklopka tog se mijenja svaki takt piksela;
//   - u domeni 125 MHz brid preklopke (registriran) ucita 10-bitnu rijec, inace pomak za 2;
//   - takt kanala = clk_pixel izravno na CC_LVDS_OBUF (CLK_SERIAL=0, kao LiteX "custom"),
//     ili uzorak 0000011111 kroz isti put kao podaci (CLK_SERIAL=1).
// U 125 MHz domeni nema logike osim pomaka i jedne XOR usporedbe (Fmax).
// Kanali: [0]=plavi (c = hsync/vsync), [1]=zeleni, [2]=crveni, [3]=takt (ccf: SB_A7/B7).
module gm_dvi_phy #(
  parameter [0:0] CLK_SERIAL = 1'b0
) (
  input        clk_pixel,
  input        clk_shift,
  input  [9:0] d_blue,
  input  [9:0] d_green,
  input  [9:0] d_red,
  output [3:0] dp,
  output [3:0] dn
);
  reg tog = 1'b0;
  always @(posedge clk_pixel) tog <= ~tog;

  reg tog_d = 1'b0, ld = 1'b0;
  reg [9:0] s0 = 10'd0, s1 = 10'd0, s2 = 10'd0, sc = 10'd0;
  always @(posedge clk_shift) begin
    tog_d <= tog;
    ld    <= tog_d ^ tog;
    if (ld) begin
      s0 <= d_blue; s1 <= d_green; s2 <= d_red; sc <= 10'b0000011111;
    end else begin
      s0 <= {2'b00, s0[9:2]}; s1 <= {2'b00, s1[9:2]};
      s2 <= {2'b00, s2[9:2]}; sc <= {2'b00, sc[9:2]};
    end
  end

  // CC_ODDR hvata D0 na rastuci, a D1 na PADAJUCI brid (cells_sim, nextpnr: posedge->negedge).
  // Izravno iz s* bi D1 nosio bit vec sljedece rijeci (par S_n[0], S_n+1[1]), pa D1 ide kroz
  // registar na padajuci brid: ODDR na sljedecem padajucem bridu uzme staru vrijednost = S_n[1].
  // (LiteX CologneChipDDROutputImpl isto rjesava CC_DFF-om na rastuci brid; ovdje je put
  // do IOSEL-a cijeli period umjesto pola -> Fmax 125 MHz domene.)
  reg [3:0] d1n = 4'd0;
  always @(negedge clk_shift) d1n <= {sc[1], s2[1], s1[1], s0[1]};

  wire [3:0] ser;
  CC_ODDR #(.CLK_INV(1'b0)) u_oddr0 (.D0(s0[0]), .D1(d1n[0]), .CLK(clk_shift), .DDR(clk_shift), .Q(ser[0]));
  CC_ODDR #(.CLK_INV(1'b0)) u_oddr1 (.D0(s1[0]), .D1(d1n[1]), .CLK(clk_shift), .DDR(clk_shift), .Q(ser[1]));
  CC_ODDR #(.CLK_INV(1'b0)) u_oddr2 (.D0(s2[0]), .D1(d1n[2]), .CLK(clk_shift), .DDR(clk_shift), .Q(ser[2]));
  generate if (CLK_SERIAL) begin : g_clk_ser
    CC_ODDR #(.CLK_INV(1'b0)) u_oddr3 (.D0(sc[0]), .D1(d1n[3]), .CLK(clk_shift), .DDR(clk_shift), .Q(ser[3]));
  end else begin : g_clk_pix
    assign ser[3] = clk_pixel;
  end endgenerate

  genvar k;
  generate for (k = 0; k < 4; k = k + 1) begin : g_lvds
    CC_LVDS_OBUF u_obuf (.A(ser[k]), .O_P(dp[k]), .O_N(dn[k]));
  end endgenerate
endmodule
