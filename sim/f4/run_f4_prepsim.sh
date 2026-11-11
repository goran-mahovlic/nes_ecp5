#!/usr/bin/env bash
# F4 (TASK-6071): kao run_f4_gatesim.sh, ali netlist nakon STAGE yosys koraka (zadano "prep") umjesto synth_gatemate
# -> razdvaja front-end (proc/opt/memory) od GateMate mapiranja.  STAGE="prep -flatten" | "synth -flatten -run :fine" ...
#   sim/f4/run_f4_prepsim.sh ime [kadrova=4]
set -euo pipefail
ROOT=$(cd "$(dirname "$0")/../.." && pwd); cd "$ROOT"
ime=$1; NF=${2:-4}; STAGE=${STAGE:-prep -flatten}
OSS=${OSS_GM:-$HOME/app/raid/tools/oss-cad-suite-20261016}; export PATH=$OSS/bin:$PATH
OUT=build/f4/prepsim/$ime; mkdir -p "$OUT"
SRC="t65/t65_ghdl.v nes.v ppu.sv apu.sv palette_ram.v f4/cart_nrom.v f4/f4_nes_sys.v"
yosys -q -l "$OUT/synth.log" -p "read_verilog -defer -sv $SRC" -p "hierarchy -top f4_nes_sys" ${YS:+-p "$YS"} \
  -p "$STAGE -top f4_nes_sys" ${POST:+-p "$POST"} -p "write_verilog -noattr $OUT/net.v"
# simlib.v bez \$connect (tran: verilator ga ne podrzava, a netlist ga ne koristi)
awk '/^module \\\$connect/{s=1} !s{print} s&&/^endmodule/{s=0}' "$OSS/share/yosys/simlib.v" > "$OUT/simlib_v.v"
verilator --binary --timing -j 16 -O3 -Wno-fatal -Wno-lint -Wno-style -Wno-WIDTH -Wno-MULTIDRIVEN -Wno-TIMESCALEMOD \
  --timescale 1ns/1ps -DGATESIM --top-module tb_f4_frame -GNFRAMES=$NF -GPREFIX="\"$OUT/k\"" --Mdir "$OUT/obj" -o tb \
  "$OSS/share/yosys/simcells.v" "$OUT/simlib_v.v" "$OUT/net.v" f4/f4_frame_crc.v sim/f4/tb_f4_frame.v 2>&1 | grep -E "%Error" -A3 || true
"$OUT/obj/tb" | tee "$OUT/tb.log" | grep KADAR
