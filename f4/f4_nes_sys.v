// F4 (TASK-6071): cijeli NES (nes.v: t65 iz t65/t65_ghdl.v + PPU + APU + cart_nrom) na clk_nes
// 10,714 MHz s djeliteljima CPU 6 / PPU 2 (opcija C), a memorije umjesto SDRAM-a u BRAM-u:
//   PRG ROM 16/32 KB ($readmemh), CPU RAM 2 KB, CHR ROM/RAM 8 KB, VRAM (nametables) 2 KB.
// BRAM se cita sinkrono (podatak 1 takt nakon adrese). CPU uzima podatak tek na cpu_ce (6 taktova),
// PPU postavi adresu na parnom, a cita na neparnom ciklusu (2 takta) -- latencija stane u oba.
// RESET_PC != 0 podmece vektor reseta ($FFFC/$FFFD), kao f3_cpu_sys (nestest automatski nacin).
// Tipke (aktivne u 1): {Right, Left, Down, Up, Start, Select, B, A} = redoslijed citanja $4016.
module f4_nes_sys #(
  parameter [4:0]  DIV_CPU      = 5'd6,
  parameter [2:0]  DIV_PPU      = 3'd2,
  parameter        PRG_HEX      = "f4/tilt_prg.hex",
  parameter        CHR_HEX      = "f4/tilt_chr.hex",
  parameter integer PRG_AW      = 15,          // 14 = 16 KB (NROM-128), 15 = 32 KB
  parameter [31:0] MAPPER_FLAGS = 32'h00000100,// f3/mkhex.py (game_loader.v oblik)
  parameter [15:0] RESET_PC     = 16'h0000
) (
  input         clk,
  input         reset,          // sinkroni, aktivan u 1 (drzi NES u resetu)
  input   [7:0] buttons,
  output  [5:0] color,
  output  [8:0] cycle,
  output  [8:0] scanline,
  output        cpu_ce,
  output [21:0] cpu_laddr,      // linearna adresa CPU-a (cart_nrom)
  output        cpu_wr,         // upis CPU-a u memoriju (RAM) -- za njuskanje varijabli igre
  output  [7:0] cpu_wdata,
  output [15:0] cpu_pc,         // adresa zadnjeg dohvata opkoda (Sync na cpu_ce)
  output        cpu_nmi         // NMI linija (aktivna u 1)
);
  wire [21:0] cpumem_addr, ppumem_addr;
  wire        cpumem_read, cpumem_write, ppumem_read, ppumem_write;
  wire  [7:0] cpumem_dout, ppumem_dout;
  reg   [7:0] cpumem_din, ppumem_din;
  wire        joy_strobe; wire [1:0] joy_clock;
  reg   [7:0] joy_bits = 8'd0;
  reg         joy_clock_d = 1'b0;
  wire [15:0] dbg_addr; wire dbg_sync;

  NES #(.DIV_CPU(DIV_CPU), .DIV_PPU(DIV_PPU), .CART_NROM(1)) nes (
    .clk(clk), .reset_nes(reset), .sys_type(2'b00), .nes_div(), .mapper_flags(MAPPER_FLAGS),
    .sample(), .color(color),
    .joypad_strobe(joy_strobe), .joypad_clock(joy_clock), .joypad_data({3'b000, joy_bits[0]}),
    .mic(1'b0), .fds_busy(1'b0), .fds_eject(1'b0), .diskside_req(), .diskside(2'b00),
    .audio_channels(5'b00000),  // APU bez zvuka (F4b)
    .cpumem_addr(cpumem_addr), .cpumem_read(cpumem_read), .cpumem_write(cpumem_write),
    .cpumem_dout(cpumem_dout), .cpumem_din(cpumem_din),
    .ppumem_addr(ppumem_addr), .ppumem_read(ppumem_read), .ppumem_write(ppumem_write),
    .ppumem_dout(ppumem_dout), .ppumem_din(ppumem_din),
    .bram_addr(), .bram_din(8'h00), .bram_dout(), .bram_write(), .bram_override(),
    .cycle(cycle), .scanline(scanline), .int_audio(1'b0), .ext_audio(1'b0), .apu_ce(cpu_ce),
    .gg(1'b1), .gg_code(129'd0), .gg_avail(), .gg_reset(1'b0), .emphasis(), .save_written(),
    .dbg_cpu_addr(dbg_addr), .dbg_cpu_sync(dbg_sync), .dbg_cpu_ce(), .dbg_nmi(cpu_nmi));
  reg  [15:0] pc_r = 0;
  always @(posedge clk) if (cpu_ce && dbg_sync) pc_r <= dbg_addr;
  assign cpu_pc    = pc_r;
  assign cpu_laddr = cpumem_addr;
  assign cpu_wr    = cpumem_write;
  assign cpu_wdata = cpumem_dout;

  // ---- dzojped: kao top.v (use_external_nes_joypad = 0) ----
  always @(posedge clk) begin
    if (joy_strobe) joy_bits <= buttons;
    else if (!joy_clock[0] && joy_clock_d) joy_bits <= {1'b0, joy_bits[7:1]};
    joy_clock_d <= joy_clock[0];
  end

  // ---- CPU strana: PRG ROM (linearno 0...) i CPU RAM (1110...) ----
  reg [7:0] prg [0:(1<<PRG_AW)-1];
  reg [7:0] ram [0:2047];
  initial $readmemh(PRG_HEX, prg);
  integer k;
  initial for (k = 0; k < 2048; k = k + 1) ram[k] = 8'h00;
  wire c_ram = (cpumem_addr[21:18] == 4'b1110);
  reg [7:0] prg_q = 0, ram_q = 0;
  reg [1:0] c_sel = 0;      // 0 = prg, 1 = ram, 2 = vektor lo, 3 = vektor hi
  always @(posedge clk) begin
    prg_q <= prg[cpumem_addr[PRG_AW-1:0]];
    ram_q <= ram[cpumem_addr[10:0]];
    if (cpumem_write && c_ram) ram[cpumem_addr[10:0]] <= cpumem_dout;
    c_sel <= c_ram ? 2'd1 :
             (RESET_PC != 0 && cpumem_addr[21] == 1'b0 && cpumem_addr[13:0] == 14'h3FFC) ? 2'd2 :
             (RESET_PC != 0 && cpumem_addr[21] == 1'b0 && cpumem_addr[13:0] == 14'h3FFD) ? 2'd3 : 2'd0;
  end
  always @* case (c_sel)
    2'd0: cpumem_din = prg_q;
    2'd1: cpumem_din = ram_q;
    2'd2: cpumem_din = RESET_PC[7:0];
    default: cpumem_din = RESET_PC[15:8];
  endcase

  // ---- PPU strana: CHR (10...) i VRAM (1100...) ----
  reg [7:0] chr [0:8191];
  reg [7:0] vram [0:2047];
  initial $readmemh(CHR_HEX, chr);
  initial for (k = 0; k < 2048; k = k + 1) vram[k] = 8'h00;
  wire p_vram = (ppumem_addr[21:18] == 4'b1100);
  reg [7:0] chr_q = 0, vram_q = 0;
  reg p_sel = 1'b0;
  always @(posedge clk) begin
    chr_q  <= chr[ppumem_addr[12:0]];
    vram_q <= vram[ppumem_addr[10:0]];
    if (ppumem_write && p_vram) vram[ppumem_addr[10:0]] <= ppumem_dout;
    if (ppumem_write && !p_vram && MAPPER_FLAGS[15]) chr[ppumem_addr[12:0]] <= ppumem_dout;
    p_sel <= p_vram;
  end
  always @* ppumem_din = p_sel ? vram_q : chr_q;
endmodule
