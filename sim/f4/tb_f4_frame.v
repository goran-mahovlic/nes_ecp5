// F4 korak 2 (TASK-6071): f4_nes_sys (NROM igra iz BRAM-a) -> kadrovi PPU-a u datoteke.
// Svaki kadar: <PREFIX>_NN.hex (61440 redaka, boja 0..63 redom y, x) + redak "KADAR n CRC pikseli taktova".
// CRC racuna f4_frame_crc (isti modul kao na plocici) -> plocica mora dati isti CRC za isti kadar.
`timescale 1ns/1ps
module tb_f4_frame;
  parameter integer NFRAMES = 12;
  parameter PREFIX = "frame";
  parameter PRG_HEX = "f4/tilt_prg.hex";
  parameter CHR_HEX = "f4/tilt_chr.hex";
  parameter integer PRG_AW = 15;
  parameter [31:0] FLAGS = 32'h00000100;
  parameter [7:0] BUTTONS = 8'h00;           // {Right, Left, Down, Up, Start, Select, B, A}
  parameter integer BTN_FROM = 0, BTN_TO = 0; // tipke pritisnute u kadrovima [BTN_FROM, BTN_TO)
  parameter [23:0] INIT_AXY = 24'h000000;
  reg clk = 0, rst = 1;
  always #46.667 clk = ~clk;            // 10,714 MHz
  wire [5:0] color; wire [8:0] cycle, scanline;
`ifdef GATESIM    // netlist je vec parametriziran (Tilt) u sintezi
  `define F4_PARAMS
`else
  `define F4_PARAMS #(.PRG_HEX(PRG_HEX), .CHR_HEX(CHR_HEX), .PRG_AW(PRG_AW), .MAPPER_FLAGS(FLAGS))
`endif
  f4_nes_sys `F4_PARAMS dut (
    .clk(clk), .reset(rst), .buttons(btns), .color(color), .cycle(cycle), .scanline(scanline),
    .cpu_ce(cpu_ce), .cpu_laddr(), .cpu_wr(), .cpu_wdata(), .cpu_pc(cpc), .cpu_nmi(nmi));
  wire cpu_ce, nmi; wire [15:0] cpc;
  wire pv, fd; wire [7:0] px, py; wire [5:0] pc; wire [31:0] fcrc; wire [16:0] fpix;
  f4_frame_crc u_crc (.clk(clk), .color(color), .cycle(cycle), .scanline(scanline),
    .pix_valid(pv), .pix_x(px), .pix_y(py), .pix_c(pc), .frame_done(fd), .frame_crc(fcrc), .frame_pix(fpix));
  wire [7:0] btns = (nf >= BTN_FROM && nf < BTN_TO) ? BUTTONS : 8'h00;
  integer f = 0, nf = 0, clks = 0, last = 0, nce = 0, npause = 0, nnmi = 0, nirq = 0;
  reg nmi_d = 0;
  reg [8*64-1:0] fn;
  initial begin
`ifndef GATESIM   // netlist nakon sinteze (sim/f4/run_f4_gatesim.sh) nema hijerarhije
    dut.nes.cpu.n768 = INIT_AXY[23:16]; dut.nes.cpu.n773 = INIT_AXY[15:8]; dut.nes.cpu.n778 = INIT_AXY[7:0];
`endif
    repeat (20) @(posedge clk); rst = 0;
  end
  always @(posedge clk) if (!rst) begin
    clks = clks + 1;
`ifndef GATESIM
    if (dut.nes.cpu_ce) begin
      nce = nce + 1;
      if (dut.nes.pause_cpu) npause = npause + 1;
      if (dut.nes.apu_irq | dut.nes.mapper_irq) nirq = nirq + 1;
    end
    nmi_d <= dut.nes.nmi; if (dut.nes.nmi && !nmi_d) nnmi = nnmi + 1;
`else
    if (cpu_ce) nce = nce + 1;
    nmi_d <= nmi; if (nmi && !nmi_d) nnmi = nnmi + 1;
`endif
    if (pv) begin
      if (px == 0 && py == 0) begin
        $sformat(fn, "%0s_%02d.hex", PREFIX, nf + 1);
        f = $fopen(fn, "w");
      end
      if (f != 0) $fwrite(f, "%02x\n", pc);
    end
    if (fd) begin
      nf = nf + 1;
      if (f != 0) begin $fclose(f); f = 0; end
      $display("KADAR %0d CRC %08X pikseli %0d taktova %0d cpu_ce %0d pauza %0d irq %0d nmi %0d PC %04X", nf, fcrc, fpix, clks - last, nce, npause, nirq, nnmi, cpc);
      last = clks; nce = 0; npause = 0; nirq = 0; nnmi = 0;
      if (nf == NFRAMES) begin : RAMDUMP
        integer k2, fr;
        $sformat(fn, "%0s_ram.hex", PREFIX);
        fr = $fopen(fn, "w");
`ifndef GATESIM
        for (k2 = 0; k2 < 2048; k2 = k2 + 1) $fwrite(fr, "%02x\n", dut.ram[k2]);
`endif
        $fclose(fr);
        $finish;
      end
    end
  end
endmodule
