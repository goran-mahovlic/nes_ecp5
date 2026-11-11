// F0 (TASK-6067) -- GateMate A1: najtanji zamjenski moduli za ECP5 primitive.
// SAMO ZA BROJANJE RESURSA (sinteza + P&R). Nije sloj platforme za rad (to je F1).
//
// ecp5pll -> CC_PLL. Dva nacina (define):
//   (zadano)   KAKAV JE: jedan CC_PLL po razlicitoj izlaznoj frekvenciji svake instance
//              (isti hz unutar instance dijeli PLL; 270 st. = CLK270 istog PLL-a).
//              Pokazuje stvarnu potraznju PLL-ova/globalnih mreza dizajna bez izmjena.
//   GM_FIT4    za P&R na A1: bez PLL-a za 6 MHz (nema potrosaca uz C_usb_speed=1) i
//              SDRAM jezgra na taktu NES-a (21,43 MHz, kao plan F6) -> 4 CC_PLL /
//              4 globalne mreze. Povrsina logike ostaje ista, mijenja se samo
//              raspodjela taktova. (Takt izravno s pina na CC_BUFG nextpnr odbija:
//              "Cell type 'CC_BUFG' is unsupported".)
module ecp5pll #(
  parameter integer in_hz = 25000000,
  parameter integer out0_hz = 25000000, out0_deg = 0, out0_tol_hz = 0,
  parameter integer out1_hz = 25000000, out1_deg = 0, out1_tol_hz = 0,
  parameter integer out2_hz = 25000000, out2_deg = 0, out2_tol_hz = 0,
  parameter integer out3_hz = 25000000, out3_deg = 0, out3_tol_hz = 0,
  parameter integer reset_en = 0, standby_en = 0, dynamic_en = 0
) (
  input clk_i, output [3:0] clk_o, input reset, input standby,
  input [1:0] phasesel, input phasedir, phasestep, phaseloadreg,
  output locked
);
  wire [3:0] lk;
  wire p0_clk0, p0_clk270;
`ifdef GM_FIT4
  // SDRAM jezgra (85,7 MHz) prelazi na takt NES-a = out2 iste instance (plan F6)
  localparam sdram_on_nes = (out0_hz == 85714285);
`else
  localparam sdram_on_nes = 0;
`endif
  generate
    if (sdram_on_nes) begin : g0_nes
      assign clk_o[0] = clk_o[2]; assign lk[0] = lk[2];
      assign clk_o[1] = clk_o[2]; assign lk[1] = lk[2];
    end else begin : g0_own
      gm_pll #(.hz(out0_hz)) p0 (.clk_i(clk_i), .clk0(p0_clk0), .clk270(p0_clk270), .locked(lk[0]));
      assign clk_o[0] = p0_clk0;
      if (out1_hz == out0_hz) begin : g1_share
        // ECP5 out1 = fazni pomak istog takta -> isti CC_PLL, izlaz CLK270
        assign clk_o[1] = (out1_deg == 270) ? p0_clk270 : p0_clk0;
        assign lk[1] = lk[0];
      end else begin : g1_own
        gm_pll #(.hz(out1_hz)) p1 (.clk_i(clk_i), .clk0(clk_o[1]), .clk270(), .locked(lk[1]));
      end
    end
    gm_pll #(.hz(out2_hz)) p2 (.clk_i(clk_i), .clk0(clk_o[2]), .clk270(), .locked(lk[2]));
    if (out3_hz == out2_hz) begin : g3_share
      assign clk_o[3] = clk_o[2]; assign lk[3] = lk[2];
    end else begin : g3_own
      gm_pll #(.hz(out3_hz)) p3 (.clk_i(clk_i), .clk0(clk_o[3]), .clk270(), .locked(lk[3]));
    end
  endgenerate
  assign locked = &lk;
endmodule

// Jedan izlaz -> jedan CC_PLL (ili ga u GM_FIT4 nacinu nema).
module gm_pll #(parameter integer hz = 25000000) (
  input clk_i, output clk0, output clk270, output locked
);
  wire clk270_int;
  assign clk270 = clk270_int;
  generate
`ifdef GM_FIT4
    if (hz == 6000000) begin : g_no6
      // 6 MHz (USB 1.0) nema potrosaca kad je C_usb_speed=1 -> bez PLL-a
      assign clk0 = 1'b0; assign clk270_int = 1'b0; assign locked = 1'b1;
    end else
`endif
    if (hz == 125000000) begin : g125
      gm_pll_cc #(.OUT("125.0")) u (.clk_i(clk_i), .clk0(clk0), .clk270(clk270_int), .locked(locked));
    end else if (hz == 48000000) begin : g48
      gm_pll_cc #(.OUT("48.0")) u (.clk_i(clk_i), .clk0(clk0), .clk270(clk270_int), .locked(locked));
    end else if (hz == 6000000) begin : g6
      gm_pll_cc #(.OUT("6.0")) u (.clk_i(clk_i), .clk0(clk0), .clk270(clk270_int), .locked(locked));
    end else if (hz == 25000000) begin : g25
      gm_pll_cc #(.OUT("25.0")) u (.clk_i(clk_i), .clk0(clk0), .clk270(clk270_int), .locked(locked));
    end else if (hz == 85714285) begin : g857
      gm_pll_cc #(.OUT("85.714285")) u (.clk_i(clk_i), .clk0(clk0), .clk270(clk270_int), .locked(locked));
    end else if (hz == 21428571) begin : g214
      gm_pll_cc #(.OUT("21.428571")) u (.clk_i(clk_i), .clk0(clk0), .clk270(clk270_int), .locked(locked));
    end else begin : g_unknown
      initial $error("gm_pll: nepoznata frekvencija");
    end
  endgenerate
endmodule

module gm_pll_cc #(parameter OUT = "25.0") (
  input clk_i, output clk0, output clk270, output locked
);
  CC_PLL #(
    .REF_CLK("25.0"), .OUT_CLK(OUT), .PERF_MD("ECONOMY"),
    .LOW_JITTER(1), .CI_FILTER_CONST(2), .CP_FILTER_CONST(4)
  ) pll (
    .CLK_REF(clk_i), .CLK_FEEDBACK(1'b0), .USR_CLK_REF(1'b0),
    .USR_LOCKED_STDY_RST(1'b0), .USR_PLL_LOCKED_STDY(), .USR_PLL_LOCKED(locked),
    .CLK0(clk0), .CLK90(), .CLK180(), .CLK270(clk270), .CLK_REF_OUT()
  );
endmodule

// ODDRX1F -> CC_ODDR (isti D0/D1 redoslijed; DDR takt = SCLK)
module ODDRX1F (input D0, input D1, input SCLK, input RST, output Q);
  CC_ODDR #(.CLK_INV(1'b0)) u (.D0(D0), .D1(D1), .CLK(SCLK), .DDR(SCLK), .Q(Q));
endmodule

// USRMCLK: na GateMate su flash pinovi korisnicki IO; za brojanje je ovo prazno
// (SCK generator flash_loadera ostaje bez potrosaca -> sinteza ga moze skratiti, ~1-2 FF).
module USRMCLK (input USRMCLKI, input USRMCLKTS);
endmodule
