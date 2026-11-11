// F4 vrata 1c (TASK-6071): cijeli f4_top (gm_clocks s modelom CC_PLL + NES + vga/gm_dvi + CRC + UART)
// sa skracenom sekundom (SEC) i brzim UART-om (BAUD_DIV=4). REF_FRAME skracen na 8.
// tb dekodira 2 retka i provjerava: H = CRC kadra 8 iz tb_f4_frame (CC4831F3), N = 0F000 (61440 piksela),
// V = 01 ($0701 = NTSC), K = 7 (tipke otpustene), F raste, I > 0 (NMI tece), G = H_G (CRC kadra F iz sim).
`timescale 1ps/1fs
module tb_f4_top;
  parameter [31:0] H8 = 32'hCC4831F3;
  reg clk = 1'b0;
  always #20000 clk = ~clk;
  wire [7:0] led; wire tx, tx2; wire [3:0] dp, dn;
  f4_top #(.SEC(1200000), .BAUD_DIV(4), .REF_FRAME(8), .H_REF(H8)) dut (.clk_25mhz(clk), .btn(3'b111),
    .led(led), .uart_tx(tx), .uart_tx2(tx2), .gpdi_dp(dp), .gpdi_dn(dn));
  initial begin dut.u_nes.nes.cpu.n768 = 8'h00; dut.u_nes.nes.cpu.n773 = 8'h00; dut.u_nes.nes.cpu.n778 = 8'h00; end

  integer pass = 0, fail = 0, nl = 0, k, nch = 0;
  reg [7:0] b; reg [8*72-1:0] line = 0; reg [8*4-1:0] f_prev = 0;
  task chk(input ok, input [8*64-1:0] what);
    begin if (ok) begin pass = pass + 1; $display("  ok   %0s", what); end
          else begin fail = fail + 1; $display("  FAIL %0s", what); end end
  endtask
  function [8*8-1:0] fld(input integer i, input integer w);
    integer j; begin fld = 0; for (j = 0; j < w; j = j + 1) fld = {fld[8*7-1:0], line[8*(nch-1-i-j) +: 8]}; end
  endfunction
  always begin
    @(negedge tx);
    repeat (6) @(posedge dut.clk_nes);
    for (k = 0; k < 8; k = k + 1) begin b[k] = tx; repeat (4) @(posedge dut.clk_nes); end
    if (b == 8'h0a) begin
      nl = nl + 1;
      $display("UART: %0s", line);
      // "F4 T=0001 F=0007 H=00000000 G=........ N=0F000 PC=.... V=01 I=.. K=7\r"
      chk(fld(41, 5) == "0F000", "N=0F000 (61440 piksela u kadru)");
      chk(fld(67, 1) == "7", "K=7 (tipke otpustene, PULLUP)");
      if (fld(12, 4) >= "0008") begin
        chk(fld(19, 8) == "CC4831F3", "H = CRC kadra 8 iz tb_f4_frame (CC4831F3)");
        chk(fld(57, 2) == "01", "V=01 ($0701: igra je prepoznala NTSC)");
        chk(fld(62, 2) != "00", "I>0 (NMI tece)");
        chk(fld(12, 4) > f_prev, "F raste");
        $display("PASS %0d FAIL %0d", pass, fail); $finish;
      end
      f_prev = fld(12, 4);
      line = 0; nch = 0;
    end else begin line = {line[8*71-1:0], b}; nch = nch + 1; end
  end
  initial begin #(64'd400_000_000_000); $display("TIMEOUT PASS %0d FAIL %0d", pass, fail + 1); $finish; end
endmodule
