// F4 (TASK-6071): kartica samo za NROM (mapper 0) s istim portovima kao cart_top (cart.sv).
// Logika = MMC0 (mappers/generic.sv) + zavrsni dio cart_top (prevodjenje adresa, CPU RAM, VRAM),
// bez ostalih 48 mappera (cart_top = 53 % LUT4 cijelog NES-a, docs/F0.md).
// Linearne adrese kao cart_top: PRG 0..., CHR 10..., VRAM 1100..., CPU RAM 1110...
// flags (game_loader.v): [15] CHR RAM, [14] zrcaljenje (1 = vertikalno), [13:11] CHR, [10:8] PRG, [7:0] mapper.
module cart_nrom (
	input             clk,
	input             ce,
	input             ppu_ce,
	input             reset,
	input      [19:0] ppuflags,
	input      [31:0] flags,
	input      [15:0] prg_ain,
	output     [21:0] prg_aout,
	input             prg_read,
	input             prg_write,
	input       [7:0] prg_din,
	output      [7:0] prg_dout,
	input       [7:0] prg_from_ram,
	output            prg_allow,
	output            prg_bus_write,
	output            prg_conflict,
	input             chr_read,
	input             chr_write,
	input       [7:0] chr_din,
	input      [13:0] chr_ain,
	output     [21:0] chr_aout,
	output      [7:0] chr_dout,
	output            has_chr_dout,
	output            chr_allow,
	output            vram_a10,
	output            vram_ce,
	output     [17:0] mapper_addr,
	input       [7:0] mapper_data_in,
	output      [7:0] mapper_data_out,
	output            mapper_prg_write,
	output            mapper_ovr,
	output            irq,
	input      [15:0] audio_in,
	output     [15:0] audio,
	output      [1:0] diskside_auto,
	input       [1:0] diskside,
	input             fds_busy,
	input             fds_eject
);
	wire cpu_ram = (prg_ain < 16'h2000);
	// PRG: 16 KB (NROM-128, flags[10:8] = 0) zrcali $8000/$C000 -- prg_mask[0] iz cart_top
	wire prg_a14 = prg_ain[14] & (flags[10:8] != 3'd0);
	assign prg_aout = cpu_ram ? {11'b11_1000_0000_0, prg_ain[10:0]} : {7'b00_0000_0, prg_a14, prg_ain[13:0]};
	assign prg_allow = cpu_ram || (prg_ain[15] && !prg_write);
	assign vram_ce   = chr_ain[13];
	assign vram_a10  = flags[14] ? chr_ain[10] : chr_ain[11];
	assign chr_allow = flags[15];
	assign chr_aout  = vram_ce ? {11'b11_0000_0000_0, vram_a10, chr_ain[9:0]} : {9'b10_0000_000, chr_ain[12:0]};
	assign prg_dout = 8'hFF;
	assign chr_dout = 8'hFF;
	assign {prg_bus_write, prg_conflict, has_chr_dout} = 3'b000;
	assign {mapper_addr, mapper_data_out, mapper_prg_write, mapper_ovr} = 28'd0;
	assign irq = 1'b0;
	assign audio = {1'b0, audio_in[15:1]};
	assign diskside_auto = 2'b00;
endmodule
