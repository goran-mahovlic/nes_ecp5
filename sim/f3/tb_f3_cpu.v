// F3 vrata 1 (TASK-6070): f3_cpu_sys vrti nestest (automatski nacin od $C000) i ispisuje trag
// po instrukciji u TRACE: "PC A X Y P S CYC" (hex, CYC decimalno). Kraj: dohvat opkoda na $0001
// (nestest zavrsi RTS-om s praznog stoga) ili MAXI instrukcija.
// t65 nema reset za A/X/Y (VHDL bez inicijalne vrijednosti -> x u simulaciji). Na plocici CPE FF-ovi
// krecu od 0 (dokaz: CRC traga s plocice = CRC simulacije); ovdje se ista pocetna 0 postavlja
// hijerarhijski. Imena su iz commitanog t65/t65_ghdl.v (ABC/X/Y -> n768/n773/n778, T65.vhd:166).
// Uz trag provjerava tempo: razmak cpu_ce = DIV_CPU taktova, bez iznimke.
`timescale 1ns/1ps
module tb_f3_cpu;
  parameter integer DIV_CPU = 6;
  parameter integer MAXI = 9000;
  parameter TRACE = "trace.txt";
  parameter [23:0] INIT_AXY = 24'h000000;   // pocetni A X Y (plocica nakon konfiguracije: I= polje UART-a)
  reg clk = 0, rst = 1;
  always #46.667 clk = ~clk;            // 10,714 MHz
  wire ce; wire tr_valid; wire [15:0] tr_pc; wire [7:0] a, x, y, p, s, r02, r03; wire [31:0] cyc;
  f3_cpu_sys #(.DIV_CPU(DIV_CPU), .PRG_HEX("f3/nestest_prg.hex")) dut (
    .clk(clk), .rst(rst), .run(1'b1), .cpu_ce(ce), .addr(), .rnw(), .dout(), .din(),
    .tr_valid(tr_valid), .tr_pc(tr_pc), .tr_a(a), .tr_x(x), .tr_y(y), .tr_p(p), .tr_s(s),
    .tr_cyc(cyc), .r02(r02), .r03(r03));
  integer f, n = 0, clks = 0, last_ce = -1, bad_gap = 0, nce = 0;
  initial begin
    dut.cpu.n768 = INIT_AXY[23:16]; dut.cpu.n773 = INIT_AXY[15:8]; dut.cpu.n778 = INIT_AXY[7:0];
    f = $fopen(TRACE, "w");
    repeat (20) @(posedge clk); rst = 0;
  end
  always @(posedge clk) if (!rst) begin
    clks = clks + 1;
    if (ce) begin
      if (last_ce >= 0 && clks - last_ce != DIV_CPU) bad_gap = bad_gap + 1;
      last_ce = clks; nce = nce + 1;
    end
    if (tr_valid) begin
      if (tr_pc == 16'h0001 || n >= MAXI) begin
        $display("KRAJ: n=%0d PC=%04X r02=%02X r03=%02X CPU ciklusa=%0d clk=%0d clk/ce=%0d.%03d los_razmak=%0d",
                 n, tr_pc, r02, r03, nce, clks, clks / nce, (clks * 1000 / nce) % 1000, bad_gap);
        $display("TEMPO: f_cpu = 10714285.7 / %0d = %0d Hz", DIV_CPU, 10714286 / DIV_CPU);
        $fclose(f); $finish;
      end
      $fwrite(f, "%04X %02X %02X %02X %02X %02X %0d\n", tr_pc, a, x, y, p, s, cyc);
      n = n + 1;
    end
  end
endmodule
