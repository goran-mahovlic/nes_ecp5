// /5 (F1, TASK-6068): doslovni port `divide_5` iz
// GateMate_demos/LiteX_DVI/intergalaktik_ulx5m_gs.py (na GS-u daje 25 MHz piksel iz 125 MHz).
// q = 3-bitni brojac mod 5 na rastucem bridu, qtemp = q[1] na padajucem (CC_DFF CLK_INV=1),
// izlaz = q[1] | qtemp. Stanja q: 000,001,010,011,110 -> q[1] visok 3 od 5 taktova, pa je
// ispuna 3,5/5 = 70 % (28 ns visoko / 12 ns nisko), NE 50 % (simulacija F1). Domena piksela
// koristi samo rastuci brid, pa ispuna ne smeta; zadrzano doslovno jer je dokazano na GS-u.
module gm_div5 (
  input  clk,      // 125 MHz
  output clk_o     // 25 MHz
);
  reg  [2:0] q = 3'd0;
  wire [2:0] qbar = {~q[0], ~q[1], ~q[2]};
  wire [2:0] d;
  assign d[0] = qbar[2] & qbar[0];
  assign d[1] = (q[1] & qbar[0]) | (qbar[1] & q[0]);
  assign d[2] = q[1] & q[0];
  always @(posedge clk) q <= d;

  wire qtemp;
  CC_DFF #(.CLK_INV(1'b1), .EN_INV(1'b0), .SR_INV(1'b0), .SR_VAL(1'b0), .INIT(1'b0)) u_neg (
    .D(q[1]), .CLK(clk), .EN(1'b1), .SR(1'b0), .Q(qtemp));

  assign clk_o = q[1] | qtemp;
endmodule
