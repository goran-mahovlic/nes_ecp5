// Ponasajni modeli GateMate primitiva koji su u yosysu samo crne kutije (cells_bb.v),
// za F1 testbench (TASK-6068). CC_DFF / CC_ODDR dolaze iz share/yosys/gatemate/cells_sim.v.
`timescale 1ps/1fs

// CC_PLL: OUT_CLK (MHz, niz) -> period; LOCK_REQ=1 -> izlazi miruju do locka.
// Lock nakon LOCK_REF_CYCLES bridova CLK_REF. CLK90/180/270 = fazni pomak CLK0.
module CC_PLL #(
  parameter REF_CLK = "", parameter OUT_CLK = "", parameter PERF_MD = "",
  parameter LOCK_REQ = 1, parameter CLK270_DOUB = 0, parameter CLK180_DOUB = 0,
  parameter LOW_JITTER = 1, parameter CI_FILTER_CONST = 2, parameter CP_FILTER_CONST = 4
)(
  input  CLK_REF, CLK_FEEDBACK, USR_CLK_REF,
  input  USR_LOCKED_STDY_RST,
  output USR_PLL_LOCKED_STDY, output reg USR_PLL_LOCKED = 1'b0,
  output reg CLK270 = 1'b0, CLK180 = 1'b0, CLK90 = 1'b0, CLK0 = 1'b0,
  output CLK_REF_OUT
);
  real out_mhz, half_ps;
  integer refcnt = 0;
  integer LOCK_REF_CYCLES = 500;      // 20 us na 25 MHz
  initial begin
    if ($sscanf(OUT_CLK, "%f", out_mhz) != 1) begin
      $display("CC_PLL model: ne mogu procitati OUT_CLK=%s", OUT_CLK); $finish;
    end
    half_ps = 1.0e6 / out_mhz / 2.0;
    $display("CC_PLL model: REF=%s OUT=%s MHz -> pola perioda %0.1f ps", REF_CLK, OUT_CLK, half_ps);
  end
  always @(posedge CLK_REF) begin
    if (refcnt < LOCK_REF_CYCLES) refcnt = refcnt + 1;
    else USR_PLL_LOCKED <= 1'b1;
  end
  // takt krece tek kad je lock (LOCK_REQ=1)
  initial begin
    wait (LOCK_REQ == 0 || USR_PLL_LOCKED);
    forever begin
      CLK0 = 1'b1; CLK180 = 1'b0; #(half_ps/2);
      CLK90 = 1'b1; CLK270 = 1'b0; #(half_ps/2);
      CLK0 = 1'b0; CLK180 = 1'b1; #(half_ps/2);
      CLK90 = 1'b0; CLK270 = 1'b1; #(half_ps/2);
    end
  end
  assign USR_PLL_LOCKED_STDY = USR_PLL_LOCKED;
  assign CLK_REF_OUT = CLK_REF;
endmodule

// CC_USR_RSTN: 1 nakon konfiguracije (model: nakon 1 us).
module CC_USR_RSTN (output reg USR_RSTN = 1'b0);
  initial #1000000 USR_RSTN = 1'b1;
endmodule
