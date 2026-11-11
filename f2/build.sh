#!/usr/bin/env bash
# F2 (TASK-6069): sinteza + P&R + gmpack --reset za f2_dvi_top na ULX5M-GS (CCGM1A1).
#   f2/build.sh [ime]   -> build/f2/<ime>/f2_dvi.bit (+ synth.log, pnr.log, stat.txt)
# Lanac kao F1: oss-cad-suite-20261016, fpga_mode=2 (ECONOMY), --freq 25 (125/10,7 MHz nose PLL-ovi).
# CLK_SERIAL=1 -> takt kanala kroz CC_ODDR (uzorak 0000011111) umjesto clk_pixel izravno.
set -euo pipefail
ROOT=$(cd "$(dirname "$0")/.." && pwd); cd "$ROOT"
ime=${1:-dvi}
OUT=${F2_OUT:-$ROOT/build/f2}/$ime; mkdir -p "$OUT"
OSS=${OSS_GM:-$HOME/app/raid/tools/oss-cad-suite-20261016}
export PATH=$OSS/bin:$PATH
SEED=${SEED:-1}; CLK_SERIAL=${CLK_SERIAL:-0}
PL=platform/gatemate
SRC="$PL/gm_rst_sync.v $PL/gm_div5.v $PL/gm_clkdiv.v $PL/gm_sdram_clk.v $PL/gm_clocks.v \
     $PL/gm_tmds_enc.v $PL/gm_dvi_phy.v $PL/gm_dvi.v framebuffer.v vga.v f2/f2_testpat.v f2/f2_dvi_top.v"
yosys -q -l "$OUT/synth.log" \
  -p "read_verilog -sv $SRC" -p "chparam -set CLK_SERIAL $CLK_SERIAL f2_dvi_top" \
  -p "synth_gatemate -top f2_dvi_top -luttree -nomx8" -p "opt_clean" \
  -p "write_json $OUT/f2.json" -p "tee -q -o $OUT/stat.txt stat"
nextpnr-himbaechel --device CCGM1A1 --json "$OUT/f2.json" --seed "$SEED" \
  --freq 25 -o ccf=$PL/ulx5m_gs.ccf -o fpga_mode=2 -o out="$OUT/f2.txt" \
  --timing-allow-fail -l "$OUT/pnr.log" >/dev/null 2>&1
gmpack --reset --input "$OUT/f2.txt" --bit "$OUT/f2_dvi.bit" 2>&1 | tee "$OUT/gmpack.log"
python3 "$HOME/.claude/regoc/tools/fpga/gm_cfgrst_check.py" "$OUT/f2_dvi.bit"
sha256sum "$OUT/f2_dvi.bit" | tee "$OUT/sha256.txt"
grep -E "Max frequency for clock|Used more|ERROR|FAIL" "$OUT/pnr.log" || true
echo "gotovo: $OUT"
