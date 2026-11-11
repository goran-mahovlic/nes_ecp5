// Sloj platforme GateMate: taktovi + reseti za NES na ULX5M-GS (F1, TASK-6068).
// Plan: docs/nes-gatemate/PLAN_NES_GATEMATE_20261111.md, "Uskladivanje taktova" A-E.
//
//   PLL1 (CC_PLL, 25 -> 125 MHz)        clk_shift  125      TMDS (CC_ODDR)        globalna 1
//        gm_div5   125 / 5              clk_pixel   25      VGA/DVI 640x480       globalna 2
//        gm_clkdiv 125 / 21             clk_usb      5,952  USB LS, LOKALNO rutanje (bez mreze)
//   PLL2 (CC_PLL, 25 -> 10,714 MHz)     clk_nes     10,714  NES jezgra (opcija C: pola takta,
//                                                           djelitelji 6/2) + SDRAM u F6  globalna 3
//        gm_sdram_clk (CC_ODDR)         sdram_clk   pin     faza za SDRAM pin (opcija B)
//   = 2 PLL-a, 3 od 4 globalne mreze. SDRAM_CLK_270=1: pin iz CLK270 istog PLL2 (+1 mreza).
//
// Reset: CC_USR_RSTN (kraj konfiguracije) | rst_i -> maskira lock (kao LiteX GateMatePLL:
// locked = USR_PLL_LOCKED & ~reset); svaka domena ima vlastiti gm_rst_sync (asinkrono
// postavljanje, sinkrono otpustanje). clk_pixel i clk_usb ovise o PLL1, clk_nes o PLL2.
// PERF_MD = ECONOMY (memorija gatemate-pll-economy: SPEED PLL na GS-u rusi ETH).
module gm_clocks #(
  parameter        NES_MHZ       = "10.714285",
  parameter integer USB_DIV      = 21,
  parameter [0:0]  SDRAM_CLK_270 = 1'b0
) (
  input  clk25,          // IO_SB_A8 (CLK0)
  input  rst_i,          // aktivan u 1, asinkron (npr. tipka); 1'b0 ako ne treba
  output clk_shift,  output rst_shift,
  output clk_pixel,  output rst_pixel,
  output clk_usb,    output rst_usb,
  output clk_nes,    output rst_nes,
  output locked_video,
  output locked_nes,
  output sdram_clk       // na pin (CC_ODDR)
);
  wire usr_rstn;
  CC_USR_RSTN u_usr_rstn (.USR_RSTN(usr_rstn));
  wire rst_any = ~usr_rstn | rst_i;

  // ---- PLL1: 125 MHz (piksel /5, USB /21) ----
  wire pll1_locked;
  CC_PLL #(
    .REF_CLK("25.0"), .OUT_CLK("125.0"), .PERF_MD("ECONOMY"),
    .LOW_JITTER(1), .LOCK_REQ(1), .CI_FILTER_CONST(2), .CP_FILTER_CONST(4)
  ) u_pll1 (
    .CLK_REF(clk25), .CLK_FEEDBACK(1'b0), .USR_CLK_REF(1'b0), .USR_LOCKED_STDY_RST(1'b0),
    .USR_PLL_LOCKED_STDY(), .USR_PLL_LOCKED(pll1_locked),
    .CLK0(clk_shift), .CLK90(), .CLK180(), .CLK270(), .CLK_REF_OUT()
  );
  assign locked_video = pll1_locked & ~rst_any;

  gm_div5 u_div5 (.clk(clk_shift), .clk_o(clk_pixel));
  gm_clkdiv #(.N(USB_DIV)) u_usbdiv (.clk(clk_shift), .clk_o(clk_usb));

  // ---- PLL2: NES (25 x 3/7) ----
  wire pll2_locked, nes_clk270;
  CC_PLL #(
    .REF_CLK("25.0"), .OUT_CLK(NES_MHZ), .PERF_MD("ECONOMY"),
    .LOW_JITTER(1), .LOCK_REQ(1), .CI_FILTER_CONST(2), .CP_FILTER_CONST(4)
  ) u_pll2 (
    .CLK_REF(clk25), .CLK_FEEDBACK(1'b0), .USR_CLK_REF(1'b0), .USR_LOCKED_STDY_RST(1'b0),
    .USR_PLL_LOCKED_STDY(), .USR_PLL_LOCKED(pll2_locked),
    .CLK0(clk_nes), .CLK90(), .CLK180(), .CLK270(nes_clk270), .CLK_REF_OUT()
  );
  assign locked_nes = pll2_locked & ~rst_any;

  generate if (SDRAM_CLK_270) begin : g_sdclk270
    gm_sdram_clk #(.INV(1'b0)) u_sdclk (.clk(nes_clk270), .pin(sdram_clk));
  end else begin : g_sdclk_inv
    gm_sdram_clk #(.INV(1'b1)) u_sdclk (.clk(clk_nes), .pin(sdram_clk));
  end endgenerate

  // ---- reset po domeni ----
  gm_rst_sync u_rs_shift (.clk(clk_shift), .rst_i(~locked_video), .rst_o(rst_shift));
  gm_rst_sync u_rs_pixel (.clk(clk_pixel), .rst_i(~locked_video), .rst_o(rst_pixel));
  gm_rst_sync u_rs_usb   (.clk(clk_usb),   .rst_i(~locked_video), .rst_o(rst_usb));
  gm_rst_sync u_rs_nes   (.clk(clk_nes),   .rst_i(~locked_nes),   .rst_o(rst_nes));
endmodule
