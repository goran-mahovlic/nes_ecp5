// Sinkronizator reseta (F1, TASK-6068): asinkrono postavljanje, sinkrono otpustanje
// nakon STAGES bridova takta domene. rst_i aktivan u 1 (npr. ~locked).
module gm_rst_sync #(
  parameter integer STAGES = 3
) (
  input  clk,
  input  rst_i,
  output rst_o
);
  (* keep *) reg [STAGES-1:0] sr = {STAGES{1'b1}};
  always @(posedge clk or posedge rst_i)
    if (rst_i) sr <= {STAGES{1'b1}};
    else       sr <= {sr[STAGES-2:0], 1'b0};
  assign rst_o = sr[STAGES-1];
endmodule
