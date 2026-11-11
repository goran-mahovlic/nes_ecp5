// F3 vrata 1b (TASK-6070): cijeli f3_top (gm_clocks s modelom CC_PLL + f3_cpu_sys + CRC + UART)
// sa skracenom sekundom (SEC) i brzim UART-om (BAUD_DIV=4). tb dekodira 3 retka i provjerava:
// T=1: N=231F (8991), PC=0001, R=0000, E=1, H = CRC nestest.log (D4D52E3B);
// T>=2: isto osim H -- 6502 reset ne brise A/X/Y, pa drugi prolaz krece od ostatka prvog
// (H je onda konstanta i ispisuje se kao referenca za plocicu).
`timescale 1ps/1fs
module tb_f3_top;
  reg clk = 1'b0;
  always #20000 clk = ~clk;
  wire [7:0] led; wire tx, tx2, sdclk;
  f3_top #(.SEC(40000), .BAUD_DIV(4)) dut (.clk_25mhz(clk), .btn(3'b111), .led(led),
    .uart_tx(tx), .uart_tx2(tx2), .sdram_clk(sdclk));
  // pocetno stanje A/X/Y kao na plocici (CPE FF = 0 nakon konfiguracije), v. tb_f3_cpu.v
  initial begin dut.u_sys.cpu.n768 = 8'h00; dut.u_sys.cpu.n773 = 8'h00; dut.u_sys.cpu.n778 = 8'h00; end

  integer pass = 0, fail = 0, nl = 0, k, nch = 0;
  reg [7:0] b; reg [8*96-1:0] line = 0; reg [8*96-1:0] h2 = 0;
  task chk(input ok, input [8*64-1:0] what);
    begin if (ok) begin pass = pass + 1; $display("  ok   %0s", what); end
          else begin fail = fail + 1; $display("  FAIL %0s", what); end end
  endtask
  // polje iz retka: znakovi [i, i+w) od pocetka (redak je fiksne duljine)
  function [8*8-1:0] fld(input integer i, input integer w);
    integer j; begin fld = 0; for (j = 0; j < w; j = j + 1) fld = {fld[8*7-1:0], line[8*(nch-1-i-j) +: 8]}; end
  endfunction
  always begin
    @(negedge tx);
    repeat (6) @(posedge dut.clk_nes);           // 1,5 bita (4 takta po bitu)
    for (k = 0; k < 8; k = k + 1) begin b[k] = tx; repeat (4) @(posedge dut.clk_nes); end
    if (b == 8'h0a) begin
      nl = nl + 1;
      $display("UART: %0s", line);
      chk(fld(12, 4) == "231F", "N=231F (8991 instrukcija)");
      chk(fld(29, 4) == "0001", "PC=0001 (RTS nesteta s praznog stoga)");
      chk(fld(61, 4) == "0000", "R=0000 ($02=$03=00: nestest PASS)");
      chk(fld(81 - 2, 1) == "1", "E=1");
      if (nl == 1) chk(fld(68, 8) == "D4D52E3B", "T=1: H = CRC nestest.log D4D52E3B");
      if (nl == 2) h2 = fld(68, 8);
      if (nl == 3) begin
        chk(fld(68, 8) == h2, "T=2 i T=3: isti H (deterministicki drugi prolaz)");
        $display("H(T>=2) = %0s", h2);
        $display("PASS %0d FAIL %0d", pass, fail); $finish;
      end
      line = 0; nch = 0;
    end else begin line = {line[8*95-1:0], b}; nch = nch + 1; end
  end
  initial begin #(64'd200_000_000_000); $display("TIMEOUT PASS %0d FAIL %0d", pass, fail + 1); $finish; end
endmodule
