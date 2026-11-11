// 8N1 UART predajnik (F1, TASK-6068). DIV = f_clk / baud (25e6/115200 = 217).
module f1_uart_tx #(parameter integer DIV = 217) (
  input        clk,
  input        start,     // jedan takt; uzima se samo kad je ready
  input  [7:0] data,
  output       ready,
  output reg   tx = 1'b1
);
  reg [9:0]  sh = 10'h3ff;
  reg [3:0]  nbit = 4'd0;
  reg [15:0] cnt = 16'd0;
  assign ready = (nbit == 0);
  always @(posedge clk) begin
    if (ready) begin
      if (start) begin sh <= {1'b1, data, 1'b0}; nbit <= 4'd10; cnt <= DIV - 1; tx <= 1'b0; end
    end else if (cnt == 0) begin
      cnt <= DIV - 1;
      sh  <= {1'b1, sh[9:1]};
      tx  <= sh[1];
      nbit <= nbit - 1'b1;
    end else cnt <= cnt - 1'b1;
  end
endmodule
