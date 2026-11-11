// Slobodni brojac u mjerenoj domeni, izlaz Grayev kod (siguran prijelaz domena: mijenja se
// jedan bit po taktu) + bit za LED (F1, TASK-6068).
module f1_cnt_gray #(parameter integer W = 28, parameter integer LEDBIT = 24) (
  input              clk,
  input              rst,
  output reg [W-1:0] gray = {W{1'b0}},
  output             led
);
  reg [W-1:0] bin = {W{1'b0}};
  always @(posedge clk)
    if (rst) begin bin <= 0; gray <= 0; end
    else begin bin <= bin + 1'b1; gray <= bin ^ (bin >> 1); end
  assign led = bin[LEDBIT];
endmodule
