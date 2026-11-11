// Vrata 1 za F1 (TASK-6068): f1_clkmeter s modelom CC_PLL, skracena vrata (GATE=2500 taktova
// clk25 = 100 us) i brzi UART (DIV=4). tb dekodira UART redak i provjerava brojeve:
// S=12500, P=2500, U=595 (+-1), N=1071 (+-1), L=11, R=0000.
`timescale 1ps/1fs
module tb_f1_clkmeter;
  reg clk = 1'b0;
  always #20000 clk = ~clk;
  wire [7:0] led; wire tx, tx2, sdclk;
  f1_clkmeter #(.GATE(2500), .BAUD_DIV(4)) dut (.clk_25mhz(clk), .btn(3'b111), .led(led),
    .uart_tx(tx), .uart_tx2(tx2), .sdram_clk(sdclk));

  // UART prijemnik: 4 takta clk25 po bitu = 160 ns
  localparam real BIT = 160000.0;
  reg [8*96-1:0] line = 0; integer nch = 0, nlines = 0;
  reg [7:0] b; integer k;
  integer pass = 0, fail = 0;
  integer T, S, P, U, N, L, R, got;
  task chk(input ok, input [8*80-1:0] what);
    begin
      if (ok) begin pass = pass + 1; $display("  ok   %0s", what); end
      else    begin fail = fail + 1; $display("  FAIL %0s", what); end
    end
  endtask
  reg [8*80-1:0] msg;
  always begin
    @(negedge tx);
    #(BIT * 1.5);
    for (k = 0; k < 8; k = k + 1) begin b[k] = tx; #(BIT); end
    if (b == 8'h0a) begin
      nlines = nlines + 1;
      $display("  UART: %0s", line);
      got = $sscanf(line, "F1 T=%d S=%d P=%d U=%d N=%d L=%b R=%b", T, S, P, U, N, L, R);
      if (nlines == 3) begin
        $sformat(msg, "redak se parsira (%0d polja)", got); chk(got == 7, msg);
        $sformat(msg, "S=%0d (ocekivano 12500)", S);       chk(S == 12500, msg);
        $sformat(msg, "P=%0d (ocekivano 2500 = S/5)", P);  chk(P == 2500, msg);
        $sformat(msg, "U=%0d (ocekivano 595,2 = S/21)", U); chk(U >= 594 && U <= 596, msg);
        $sformat(msg, "N=%0d (ocekivano 1071,4)", N);      chk(N >= 1070 && N <= 1072, msg);
        chk(L == 3, "L=11 (oba PLL-a u locku)");
        chk(R == 0, "R=0000 (nijedna domena u resetu)");
        chk(T == 3 || T == 2 || T == 4, "T broji sekunde (redak 3)");
        chk(led[5] == 1'b0 && led[6] == 1'b0, "LED5/6 (lock) svijetle (aktivne u 0)");
        $display("F1 tb_f1_clkmeter: PASS %0d FAIL %0d", pass, fail);
        $finish;
      end
      line = 0;
    end else if (b != 8'h0d) line = {line[8*95-1:0], b};
  end
  initial begin #20000000000; $display("F1 tb_f1_clkmeter: TIMEOUT FAIL 1"); $finish; end
endmodule
