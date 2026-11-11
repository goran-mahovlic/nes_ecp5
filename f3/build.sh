#!/usr/bin/env bash
# F3 (TASK-6070): sinteza + P&R + gmpack --reset za f3_top (t65 + RAM + nestest PRG) na ULX5M-GS.
#   f3/build.sh [ime]   -> build/f3/<ime>/f3_top.bit (+ synth.log, pnr.log, stat.txt)
# t65 dolazi kao commitani Verilog (t65/t65_ghdl.v, t65/gen_verilog.sh) -> bez ghdl plugina.
set -euo pipefail
ROOT=$(cd "$(dirname "$0")/.." && pwd); cd "$ROOT"
ime=${1:-nestest}
OUT=${F3_OUT:-$ROOT/build/f3}/$ime; mkdir -p "$OUT"
OSS=${OSS_GM:-$HOME/app/raid/tools/oss-cad-suite-20261016}
export PATH=$OSS/bin:$PATH
SEED=${SEED:-1}
PL=platform/gatemate
SRC="$PL/gm_rst_sync.v $PL/gm_div5.v $PL/gm_clkdiv.v $PL/gm_sdram_clk.v $PL/gm_clocks.v \
     t65/t65_ghdl.v f3/f3_cpu_sys.v f1/f1_uart_tx.v f3/f3_top.v"
yosys -q -l "$OUT/synth.log" \
  -p "read_verilog -sv $SRC" \
  -p "synth_gatemate -top f3_top -luttree -nomx8" -p "opt_clean" \
  -p "write_json $OUT/f3.json" -p "tee -q -o $OUT/stat.txt stat"
nextpnr-himbaechel --device CCGM1A1 --json "$OUT/f3.json" --seed "$SEED" \
  --freq 25 -o ccf=$PL/ulx5m_gs.ccf -o fpga_mode=2 -o out="$OUT/f3.txt" \
  --timing-allow-fail -l "$OUT/pnr.log" >/dev/null 2>&1
gmpack --reset --input "$OUT/f3.txt" --bit "$OUT/f3_top.bit" 2>&1 | tee "$OUT/gmpack.log"
python3 "$HOME/.claude/regoc/tools/fpga/gm_cfgrst_check.py" "$OUT/f3_top.bit"
sha256sum "$OUT/f3_top.bit" | tee "$OUT/sha256.txt"
grep -E "Max frequency for clock|Used more|ERROR|FAIL" "$OUT/pnr.log" || true
echo "gotovo: $OUT"
