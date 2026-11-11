#!/usr/bin/env bash
# F4 (TASK-6071): simulacija NAKON SINTEZE -- f4_nes_sys kroz synth_gatemate (isti tok kao f4/build.sh,
# bez IO) -> netlist + cells_sim.v -> verilator s tb_f4_frame (GATESIM). Hvata razlike sinteze i RTL sima
# (x/init vrijednosti, mapiranje BRAM-a). Zastavica YS="..." doda yosys naredbe prije synth_gatemate.
#   sim/f4/run_f4_gatesim.sh [ime] [kadrova=6]
set -euo pipefail
ROOT=$(cd "$(dirname "$0")/../.." && pwd); cd "$ROOT"
ime=${1:-nes}; NF=${2:-6}
OSS=${OSS_GM:-$HOME/app/raid/tools/oss-cad-suite-20261016}; export PATH=$OSS/bin:$PATH
OUT=build/f4/gatesim/$ime; mkdir -p "$OUT"
SRC="t65/t65_ghdl.v nes.v ppu.sv apu.sv palette_ram.v f4/cart_nrom.v f4/f4_nes_sys.v"
yosys -q -l "$OUT/synth.log" -p "read_verilog -defer -sv $SRC" -p "hierarchy -top f4_nes_sys" ${YS:+-p "$YS"} \
  -p "synth_gatemate -top f4_nes_sys -luttree -nomx8 -noiopad" -p "opt_clean" \
  -p "write_verilog -noattr $OUT/gate.v"
verilator --binary --timing -j 16 -O3 -Wno-fatal -Wno-lint -Wno-style -Wno-WIDTH -Wno-MULTIDRIVEN -Wno-TIMESCALEMOD \
  --timescale 1ns/1ps -DGATESIM --top-module tb_f4_frame -GNFRAMES=$NF -GPREFIX="\"$OUT/k\"" --Mdir "$OUT/obj" -o tb \
  "$OSS/share/yosys/gatemate/cells_sim.v" "$OUT/gate.v" f4/f4_frame_crc.v sim/f4/tb_f4_frame.v 2>&1 | grep -E "%Error" -A3 || true
"$OUT/obj/tb" | tee "$OUT/tb.log" | grep KADAR
