// F3 (TASK-6070): NES CPU sustav bez PPU-a -- t65 (iz t65/t65_ghdl.v) + 2 KB radne memorije
// ($0000-$1FFF, zrcaljeno) + PRG ROM NROM ($8000-$FFFF, 16 KB zrcaljeno ili 32 KB) u BRAM-u.
// Takt: clk_nes 10,714 MHz; CPU enable jednom u DIV_CPU taktova (opcija C: 6 -> 1,786 MHz).
// Ostatak sabirnice ($2000-$7FFF) cita $FF, pisanje se ignorira (nema PPU/APU u F3).
// RESET_PC != 0 podmece vektor reseta ($FFFC/$FFFD) -- nestest automatski nacin krece od $C000.
//
// Trag (isti signali za simulaciju i plocicu): tr_valid je jedan takt po instrukciji, ciklus nakon
// dohvata opkoda; tr_pc = adresa opkoda, tr_a/x/y/p/s = stanje PRIJE te instrukcije (kao nestest.log),
// tr_cyc = broj CPU ciklusa od otpustanja reseta (nestest: prvi redak CYC:7).
module f3_cpu_sys #(
  parameter integer DIV_CPU  = 6,
  parameter         PRG_HEX  = "f3/nestest_prg.hex",
  parameter integer PRG_AW   = 14,          // 14 = 16 KB (NROM-128), 15 = 32 KB
  parameter [15:0]  RESET_PC = 16'hC000
) (
  input             clk,
  input             rst,                    // sinkroni, aktivan u 1
  input             run,                    // 0 = CPU stoji (Enable se ne daje)
  output            cpu_ce,
  output     [15:0] addr,
  output            rnw,
  output     [7:0]  dout,
  output     [7:0]  din,
  output reg        tr_valid = 1'b0,
  output reg [15:0] tr_pc = 0,
  output reg [7:0]  tr_a = 0,
  output reg [7:0]  tr_x = 0,
  output reg [7:0]  tr_y = 0,
  output reg [7:0]  tr_p = 0,
  output reg [7:0]  tr_s = 0,
  output reg [31:0] tr_cyc = 0,
  output reg [7:0]  r02 = 0,                // rezultat nestesta (0 = PASS)
  output reg [7:0]  r03 = 0
);
  // ---- djelitelj CPU-a (nes.v: div_cpu 1..div_cpu_n, cpu_ce kad je jednak) ----
  reg [4:0] div = 5'd1;
  wire ce = run && (div == DIV_CPU);
  assign cpu_ce = ce;
  always @(posedge clk)
    if (rst) div <= 5'd1;
    else if (run) div <= ce ? 5'd1 : div + 1'b1;

  // ---- CPU ----
  wire [23:0] a24;
  wire sync;
  wire [7:0] d_i, d_a, d_x, d_y, d_s, d_p;
  T65 cpu (
    .Mode(2'b00), .BCD_en(1'b0), .Res_n(~rst), .Clk(clk), .Enable(ce),
    .A(a24), .DI(rnw ? din : dout), .DO(dout),
    .Rdy(1'b1), .Abort_n(1'b1), .IRQ_n(1'b1), .NMI_n(1'b1), .SO_n(1'b1),
    .R_W_n(rnw), .Sync(sync), .EF(), .MF(), .XF(), .ML_n(), .VP_n(), .VDA(), .VPA(),
    .\DEBUG[I] (d_i), .\DEBUG[A] (d_a), .\DEBUG[X] (d_x), .\DEBUG[Y] (d_y),
    .\DEBUG[S] (d_s), .\DEBUG[P] (d_p), .NMI_ack());
  assign addr = a24[15:0];

  // ---- memorije (BRAM, sinkrono citanje; podatak je spreman 1 takt nakon promjene adrese,
  //      a CPU ga uzima tek na sljedecem cpu_ce = DIV_CPU taktova kasnije) ----
  reg [7:0] ram [0:2047];
  reg [7:0] prg [0:(1<<PRG_AW)-1];
  initial $readmemh(PRG_HEX, prg);
  integer k;
  initial for (k = 0; k < 2048; k = k + 1) ram[k] = 8'h00;   // BRAM u bitstreamu krece od 0
  reg [7:0] ram_q = 0, prg_q = 0;
  wire ram_cs = (addr[15:13] == 3'b000);
  wire prg_cs = addr[15];
  always @(posedge clk) begin
    ram_q <= ram[addr[10:0]];
    if (ce && !rnw && ram_cs) ram[addr[10:0]] <= dout;
  end
  always @(posedge clk) prg_q <= prg[addr[PRG_AW-1:0]];
  reg [1:0] sel = 0;      // 0 = ram, 1 = prg, 2 = vektor lo, 3 = vektor hi; $FF izvan
  reg       open_bus = 1'b0;
  always @(posedge clk) begin
    open_bus <= !(ram_cs || prg_cs);
    sel <= ram_cs ? 2'd0 :
           (RESET_PC != 0 && addr == 16'hFFFC) ? 2'd2 :
           (RESET_PC != 0 && addr == 16'hFFFD) ? 2'd3 : 2'd1;
  end
  assign din = open_bus ? 8'hFF :
               sel == 2'd0 ? ram_q : sel == 2'd1 ? prg_q :
               sel == 2'd2 ? RESET_PC[7:0] : RESET_PC[15:8];

  // ---- rezultat nestesta: zrcalo upisa u $02/$03 ----
  always @(posedge clk)
    if (rst) begin r02 <= 0; r03 <= 0; end
    else if (ce && !rnw && ram_cs && addr[10:1] == 10'd1) begin
      if (addr[0]) r03 <= dout; else r02 <= dout;
    end

  // ---- trag: PC na cpu_ce ciklusa dohvata opkoda (Sync); registri na SLJEDECEM cpu_ce, jer
  //      t65 (kao 6502) upisuje rezultat prethodne instrukcije na kraju ciklusa dohvata ----
  reg [31:0] cyc = 0;
  reg pend = 1'b0;
  always @(posedge clk) begin
    tr_valid <= 1'b0;
    if (rst) begin cyc <= 0; pend <= 1'b0; end
    else if (ce) begin
      cyc  <= cyc + 1'b1;
      pend <= sync;
      if (sync) begin tr_pc <= addr; tr_cyc <= cyc; end
      if (pend) begin
        tr_valid <= 1'b1;
        tr_a <= d_a; tr_x <= d_x; tr_y <= d_y; tr_p <= d_p; tr_s <= d_s;
      end
    end
  end
endmodule
