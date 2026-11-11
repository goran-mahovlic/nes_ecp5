#!/usr/bin/env bash
# F2 vrata 1 (TASK-6069): iverilog iz zadanog lanca oss-cad-suite-20261016.
#   1a tb_tmds_enc : gm_tmds_enc prema NES tmds_encoder.v (referentni vektor) + dekodiranje
#   1b tb_f2_dvi   : cijeli top, dekodirani serijski izlaz -> tajming + kadar (PPM)
#   1c check_frame : kadar iz simulacije == ocekivana testna slika (tocno, piksel po piksel)
set -euo pipefail
cd "$(dirname "$0")"; ROOT=$(cd ../.. && pwd)
OSS=${OSS_GM:-$HOME/app/raid/tools/oss-cad-suite-20261016}
export PATH=$OSS/bin:$PATH
CELLS=$OSS/share/yosys/gatemate/cells_sim.v
PL=$ROOT/platform/gatemate
OUT=${OUT:-$ROOT/build/f2/sim}; mkdir -p "$OUT"
iverilog -g2012 -o "$OUT/tb_tmds_enc.vvp" -s tb_tmds_enc $ROOT/tmds_encoder.v $PL/gm_tmds_enc.v tb_tmds_enc.v
vvp -n "$OUT/tb_tmds_enc.vvp" | tee "$OUT/tb_tmds_enc.log"
iverilog -g2012 -DOUTDIR=\"$OUT\" -o "$OUT/tb_f2_dvi.vvp" -s tb_f2_dvi ../f1/gm_sim_models.v "$CELLS" \
  $PL/gm_rst_sync.v $PL/gm_div5.v $PL/gm_clkdiv.v $PL/gm_sdram_clk.v $PL/gm_clocks.v \
  $PL/gm_tmds_enc.v $PL/gm_dvi_phy.v $PL/gm_dvi.v \
  $ROOT/framebuffer.v $ROOT/vga.v $ROOT/f2/f2_testpat.v $ROOT/f2/f2_dvi_top.v tb_f2_dvi.v
vvp -n "$OUT/tb_f2_dvi.vvp" | tee "$OUT/tb_f2_dvi.log"
python3 "$ROOT/f2/check_frame.py" --spec f2 --exact "$OUT/tb_f2_frame.ppm" | tee "$OUT/check_sim.log"
! grep -q "FAIL [1-9]" "$OUT"/tb_*.log
grep -q "^PASS" "$OUT/check_sim.log"
