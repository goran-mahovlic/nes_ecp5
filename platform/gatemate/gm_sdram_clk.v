// Takt SDRAM pina iz takta jezgre bez vlastitog PLL-a i globalne mreze (F1, TASK-6068,
// plan "Uskladivanje taktova" B): CC_ODDR u IO celiji.
//   INV=1: D0=0, D1=1 -> pin = invertirani clk (180 st., kao --sdram-clk inv)
//   INV=0: D0=1, D1=0 -> pin = clk (koristi se uz clk = CLK90/CLK270 istog CC_PLL-a)
module gm_sdram_clk #(
  parameter [0:0] INV = 1'b1
) (
  input  clk,
  output pin
);
  CC_ODDR #(.CLK_INV(1'b0)) u_oddr (
    .D0(~INV), .D1(INV), .CLK(clk), .DDR(clk), .Q(pin));
endmodule
