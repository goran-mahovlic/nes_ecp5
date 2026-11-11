// F4 korak 1 (TASK-6071): regresija F3 kroz CIJELI nes.v (PPU, APU, DMA, cart_nrom, BRAM iz f4_nes_sys).
// nestest (automatski nacin od $C000) mora dati isti trag kao nestest.log: "PC A X Y P S CYC".
// Uzorkovanje kao F3 (f3_cpu_sys): PC na cpu_ce dohvata opkoda (Sync), registri na sljedecem cpu_ce.
// A/X/Y t65 ne resetira -> postavljaju se hijerarhijski (imena iz t65_ghdl.v, kao tb_f3_cpu).
`timescale 1ns/1ps
module tb_f4_nestest;
  parameter integer MAXI = 9000;
  parameter TRACE = "trace.txt";
  parameter [4:0] DIV_CPU = 5'd6;
  parameter [2:0] DIV_PPU = 3'd2;
  reg clk = 0, rst = 1;
  always #46.667 clk = ~clk;            // 10,714 MHz
  wire ce; wire [21:0] la;
  f4_nes_sys #(.DIV_CPU(DIV_CPU), .DIV_PPU(DIV_PPU), .PRG_HEX("f3/nestest_prg.hex"),
    .CHR_HEX("f4/nestest_chr.hex"), .PRG_AW(14), .MAPPER_FLAGS(32'h0), .RESET_PC(16'hC000)) dut (
    .clk(clk), .reset(rst), .buttons(8'h00), .color(), .cycle(), .scanline(), .cpu_ce(ce),
    .cpu_laddr(la), .cpu_wr(), .cpu_wdata(), .cpu_pc(), .cpu_nmi());
  wire        sync = dut.nes.cpu.Sync;
  wire [15:0] pc   = dut.nes.cpu_addr;
  wire  [7:0] ra = dut.nes.cpu.\DEBUG[A] , rx = dut.nes.cpu.\DEBUG[X] , ry = dut.nes.cpu.\DEBUG[Y] ,
              rp = dut.nes.cpu.\DEBUG[P] , rs = dut.nes.cpu.\DEBUG[S] ;
  integer f, n = 0, cyc = 0, clks = 0, last_ce = -1, bad_gap = 0, pend = 0, tr_cyc = 0;
  reg [15:0] tr_pc;
  reg [7:0] r02 = 0, r03 = 0;
  initial begin
    dut.nes.cpu.n768 = 0; dut.nes.cpu.n773 = 0; dut.nes.cpu.n778 = 0;
    f = $fopen(TRACE, "w");
    repeat (20) @(posedge clk); rst = 0;
  end
  always @(posedge clk) if (!rst) begin
    clks = clks + 1;
    if (ce) begin
      if (last_ce >= 0 && clks - last_ce != DIV_CPU) bad_gap = bad_gap + 1;
      last_ce = clks;
      if (!dut.nes.cpu_rnw && pc[15:1] == 15'h0001) begin if (pc[0]) r03 = dut.nes.cpu_dout; else r02 = dut.nes.cpu_dout; end
      if (pend) begin
        if (tr_pc == 16'h0001 || n >= MAXI) begin
          $display("KRAJ: n=%0d PC=%04X r02=%02X r03=%02X CPU ciklusa=%0d clk=%0d los_razmak=%0d",
                   n, tr_pc, r02, r03, cyc, clks, bad_gap);
          $fclose(f); $finish;
        end
        $fwrite(f, "%04X %02X %02X %02X %02X %02X %0d\n", tr_pc, ra, rx, ry, rp, rs, tr_cyc);
        n = n + 1;
      end
      pend = sync;
      if (sync) begin tr_pc = pc; tr_cyc = cyc; end
      cyc = cyc + 1;
    end
  end
endmodule
