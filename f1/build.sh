#!/usr/bin/env bash
# F1 (TASK-6068): sinteza + P&R + gmpack --reset za f1_clkmeter na ULX5M-GS (CCGM1A1).
#   f1/build.sh [ime]        -> build/f1/<ime>/f1_clkmeter.bit (+ synth.log, pnr.log, stat.txt)
# Lanac: zadani oss-cad-suite-20261016 (ili OSS_GM=<mapa>). fpga_mode=2 (ECONOMY, kao F0); --freq 25 = cilj za clk25, piksel i USB (125 i 10,7 MHz nose PLL-ovi).
set -euo pipefail
ROOT=$(cd "$(dirname "$0")/.." && pwd); cd "$ROOT"
ime=${1:-clkmeter}
OUT=${F1_OUT:-$ROOT/build/f1}/$ime; mkdir -p "$OUT"
OSS=${OSS_GM:-$HOME/app/raid/tools/oss-cad-suite-20261016}
export PATH=$OSS/bin:$PATH
SEED=${SEED:-1}
PL=platform/gatemate
SRC="$PL/gm_rst_sync.v $PL/gm_div5.v $PL/gm_clkdiv.v $PL/gm_sdram_clk.v $PL/gm_clocks.v \
     f1/f1_uart_tx.v f1/f1_cnt_gray.v f1/f1_clkmeter.v"
yosys -q -l "$OUT/synth.log" \
  -p "read_verilog -sv $SRC" \
  -p "synth_gatemate -top f1_clkmeter -luttree -nomx8" -p "opt_clean" \
  -p "write_json $OUT/f1.json" -p "tee -q -o $OUT/stat.txt stat"
nextpnr-himbaechel --device CCGM1A1 --json "$OUT/f1.json" --seed "$SEED" \
  --freq 25 -o ccf=$PL/ulx5m_gs.ccf -o fpga_mode=2 -o out="$OUT/f1.txt" \
  --timing-allow-fail -l "$OUT/pnr.log" >/dev/null 2>&1
gmpack --reset --input "$OUT/f1.txt" --bit "$OUT/f1_clkmeter.bit" 2>&1 | tee "$OUT/gmpack.log"
python3 "$HOME/.claude/regoc/tools/fpga/gm_cfgrst_check.py" "$OUT/f1_clkmeter.bit"
sha256sum "$OUT/f1_clkmeter.bit" | tee "$OUT/sha256.txt"
grep -E "Max frequency for clock|Used more|ERROR|FAIL" "$OUT/pnr.log" || true
echo "gotovo: $OUT"
