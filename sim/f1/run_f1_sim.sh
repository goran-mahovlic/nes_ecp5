#!/usr/bin/env bash
# F1 vrata 1 (TASK-6068): iverilog iz zadanog lanca oss-cad-suite-20261016.
set -euo pipefail
cd "$(dirname "$0")"; ROOT=$(cd ../.. && pwd)
OSS=${OSS_GM:-$HOME/app/raid/tools/oss-cad-suite-20261016}
export PATH=$OSS/bin:$PATH
CELLS=$OSS/share/yosys/gatemate/cells_sim.v
PL=$ROOT/platform/gatemate
OUT=${OUT:-$ROOT/build/f1/sim}; mkdir -p "$OUT"
iverilog -g2012 -o "$OUT/tb_gm_clocks.vvp" -s tb_gm_clocks gm_sim_models.v "$CELLS" \
  $PL/gm_rst_sync.v $PL/gm_div5.v $PL/gm_clkdiv.v $PL/gm_sdram_clk.v $PL/gm_clocks.v tb_gm_clocks.v
vvp -n "$OUT/tb_gm_clocks.vvp" | tee "$OUT/tb_gm_clocks.log"
iverilog -g2012 -o "$OUT/tb_f1_clkmeter.vvp" -s tb_f1_clkmeter gm_sim_models.v "$CELLS" \
  $PL/gm_rst_sync.v $PL/gm_div5.v $PL/gm_clkdiv.v $PL/gm_sdram_clk.v $PL/gm_clocks.v \
  $ROOT/f1/f1_uart_tx.v $ROOT/f1/f1_cnt_gray.v $ROOT/f1/f1_clkmeter.v tb_f1_clkmeter.v
vvp -n "$OUT/tb_f1_clkmeter.vvp" | tee "$OUT/tb_f1_clkmeter.log"
! grep -q "FAIL [1-9]" "$OUT"/tb_*.log
