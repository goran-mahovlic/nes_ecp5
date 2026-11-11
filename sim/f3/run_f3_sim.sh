#!/usr/bin/env bash
# F3 vrata 1 (TASK-6070): iverilog sim t65 (t65/t65_ghdl.v) + RAM + nestest PRG; trag usporeduje
# f3/cmp_trace.py s nestest.log. DIV_CPU 6 (opcija C) i kontrolno 12 (izvorni NES) i 2.
#   sim/f3/run_f3_sim.sh [log_dir]      (nestest.log: NESTEST_LOG=<put> ili f3/fetch_nestest.sh)
set -euo pipefail
ROOT=$(cd "$(dirname "$0")/../.." && pwd); cd "$ROOT"
export PATH=${OSS_GM:-$HOME/app/raid/tools/oss-cad-suite-20261016}/bin:$PATH
OUT=${1:-build/f3/sim}; mkdir -p "$OUT"
REF=${NESTEST_LOG:-build/f3/nestest.log}
[ -s "$REF" ] || f3/fetch_nestest.sh "$REF"
for d in 6 12 2; do
  iverilog -g2012 -o "$OUT/tb_$d.vvp" -P tb_f3_cpu.DIV_CPU=$d -P "tb_f3_cpu.TRACE=\"$OUT/trace_div$d.txt\"" \
    t65/t65_ghdl.v f3/f3_cpu_sys.v sim/f3/tb_f3_cpu.v
  vvp -n "$OUT/tb_$d.vvp" | tee "$OUT/tb_div$d.log"
  # P bit 4 (B) nije registar u 6502 (postoji samo na stogu); t65 ga drzi na 1, nestest.log ispisuje 0
  python3 f3/cmp_trace.py "$REF" "$OUT/trace_div$d.txt" --p-mask 0xEF | tee "$OUT/cmp_div$d.log"
  python3 f3/cmp_trace.py "$REF" "$OUT/trace_div$d.txt" | grep PRVI -A2 >> "$OUT/cmp_div$d.log" || true
  awk 'NR==1{c=$7} {$7=$7-c; print}' "$OUT/trace_div$d.txt" > "$OUT/trace_div$d.rel"
done
echo "--- trag DIV 6 / 12 / 2 (CYC od prvog retka) jednak = nema ovisnosti o medjutaktovima mastera:"
cmp "$OUT/trace_div6.rel" "$OUT/trace_div12.rel" && cmp "$OUT/trace_div6.rel" "$OUT/trace_div2.rel" && echo "ISTO (cmp 0, $(wc -l < "$OUT/trace_div6.rel") redaka)"
echo "--- pocetno stanje s plocice (UART I=CEFFFF34FD): A=CE X=FF Y=FF -> H mora biti 0CA27716:"
iverilog -g2012 -o "$OUT/tb_i.vvp" -P tb_f3_cpu.INIT_AXY=24\'hCEFFFF -P "tb_f3_cpu.TRACE=\"$OUT/trace_div6_ceffff.txt\"" \
  t65/t65_ghdl.v f3/f3_cpu_sys.v sim/f3/tb_f3_cpu.v
vvp -n "$OUT/tb_i.vvp" | head -1
python3 f3/cmp_trace.py "$REF" "$OUT/trace_div6_ceffff.txt" --p-mask 0xEF | tee "$OUT/cmp_div6_ceffff.log"
echo "--- f3_top (CC_PLL model + CRC + UART), ~70 s:"
OSS=${OSS_GM:-$HOME/app/raid/tools/oss-cad-suite-20261016}; PL=platform/gatemate
iverilog -g2012 -o "$OUT/tb_top.vvp" -s tb_f3_top sim/f1/gm_sim_models.v "$OSS/share/yosys/gatemate/cells_sim.v" \
  $PL/gm_rst_sync.v $PL/gm_div5.v $PL/gm_clkdiv.v $PL/gm_sdram_clk.v $PL/gm_clocks.v \
  t65/t65_ghdl.v f3/f3_cpu_sys.v f1/f1_uart_tx.v f3/f3_top.v sim/f3/tb_f3_top.v 2>/dev/null
vvp -n "$OUT/tb_top.vvp" | tee "$OUT/tb_f3_top.log"
grep -q "PASS 14 FAIL 0" "$OUT/tb_f3_top.log" && grep -q "PODUDARNO: 8991/8991" "$OUT/cmp_div6.log"
