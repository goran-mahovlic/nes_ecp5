#!/usr/bin/env bash
# F4 vrata 1 (TASK-6071), verilator iz oss-cad-suite-20261016 (iverilog ne prima nes.v: deklaracija nakon upotrebe).
#  1  nestest kroz CIJELI nes.v (f4_nes_sys, DIV 6/2 i 12/4) -> nestest.log 8991/8991 + isti trag
#  2  Super Tilt Bro (NROM-256): kadrovi PPU-a 1..120 -> cynes piksel po piksel (f4/cmp_emu.py) + PNG
#  2b isto s tipkom Start u kadrovima 60..69 (put dzojpeda) -> 200 kadrova prema cynes
#  2c 1000 kadrova -> f4/ref_tilt.txt (stalni dio slike za check_frame --spec f4) + CRC za f4/check_uart.py
#  2d slucajno pocetno stanje registara bez inita (--x-initial unique, 6 sjemena) -> kadar 12 isti
#  3  cijeli f4_top (model CC_PLL, vga/gm_dvi, CRC, UART) -> tb_f4_top PASS
#  4  netlist nakon synth_gatemate (run_f4_gatesim.sh) -> isti CRC kadrova 1..8 kao RTL
#   sim/f4/run_f4_sim.sh [log_dir]     CYNES_PY=<python s cynes> (zadano ~/app/tmp/tools/nes-cynes)
set -euo pipefail
ROOT=$(cd "$(dirname "$0")/../.." && pwd); cd "$ROOT"
OSS=${OSS_GM:-$HOME/app/raid/tools/oss-cad-suite-20261016}; export PATH=$OSS/bin:$PATH
PY=${CYNES_PY:-$HOME/app/tmp/tools/nes-cynes/venv/bin/python}
OUT=${1:-build/f4/sim}; mkdir -p "$OUT"
REF=${NESTEST_LOG:-build/f3/nestest.log}; [ -s "$REF" ] || f3/fetch_nestest.sh "$REF"
VL="verilator --binary --timing -j 16 -O3 -Wno-fatal -Wno-lint -Wno-style -Wno-WIDTH -Wno-MULTIDRIVEN -Wno-TIMESCALEMOD"
NES="t65/t65_ghdl.v nes.v ppu.sv apu.sv palette_ram.v f4/cart_nrom.v f4/f4_nes_sys.v"
PL=platform/gatemate
python3 f3/mkhex.py f3/nestest.nes /dev/null f4/nestest_chr.hex
python3 f3/mkhex.py rom/game_tilt.nes f4/tilt_prg.hex f4/tilt_chr.hex

echo "=== 1: nestest kroz nes.v"
for d in "6 2" "12 4"; do set -- $d
  $VL --timescale 1ns/1ps --top-module tb_f4_nestest -GDIV_CPU=$1 -GDIV_PPU=$2 -GTRACE="\"$OUT/trace_nes_div$1.txt\"" \
    --Mdir "$OUT/obj_nestest$1" -o tb $NES sim/f4/tb_f4_nestest.v 2>&1 | grep -E "%Error" -A3 || true
  "$OUT/obj_nestest$1/tb" | grep KRAJ | tee "$OUT/tb_nestest_div$1.log"
  python3 f3/cmp_trace.py "$REF" "$OUT/trace_nes_div$1.txt" --p-mask 0xEF | tee "$OUT/cmp_nes_div$1.log"
  awk 'NR==1{c=$7} {$7=$7-c; print}' "$OUT/trace_nes_div$1.txt" > "$OUT/trace_nes_div$1.rel"
done
cmp "$OUT/trace_nes_div6.rel" "$OUT/trace_nes_div12.rel" && echo "trag DIV 6/2 = 12/4 (cmp 0)"

frames() {  # $1 obj, $2 prefiks, $3 broj kadrova, ostalo = -G parametri
  local obj=$1 pre=$2 n=$3; shift 3
  $VL --timescale 1ns/1ps --top-module tb_f4_frame -GNFRAMES=$n -GPREFIX="\"$pre\"" "$@" --Mdir "$OUT/$obj" -o tb \
    $NES f4/f4_frame_crc.v sim/f4/tb_f4_frame.v 2>&1 | grep -E "%Error" -A3 || true
}
echo "=== 2: kadrovi Super Tilt Bro -> cynes"
frames obj_frame "$OUT/tilt" 120; "$OUT/obj_frame/tb" > "$OUT/tb_f4_frame.log"; grep -c KADAR "$OUT/tb_f4_frame.log"
python3 f4/frame2png.py "$OUT/tilt_120.hex" "$OUT/tilt_120.png"
$PY f4/cmp_emu.py rom/game_tilt.nes "$OUT/tilt" 120 --poke 0x0701=1@3 --od 6 > "$OUT/cmp_emu_poke.log"; tail -1 "$OUT/cmp_emu_poke.log"
echo "=== 2b: tipka Start u kadrovima 60..69"
mkdir -p "$OUT/start"; frames obj_start "$OUT/start/tilt" 200 -GBUTTONS=8\'h08 -GBTN_FROM=60 -GBTN_TO=70
"$OUT/obj_start/tb" > "$OUT/tb_f4_start.log"; python3 f4/frame2png.py "$OUT/start/tilt_200.hex" "$OUT/start_200.png"
$PY f4/cmp_emu.py rom/game_tilt.nes "$OUT/start/tilt" 200 --poke 0x0701=1@3 --od 6 --tipke 0x08@60:70 > "$OUT/cmp_emu_start.log"; tail -1 "$OUT/cmp_emu_start.log"
echo "=== 2c: 1000 kadrova -> referenca + CRC"
mkdir -p "$OUT/dugo"; frames obj_frame1000 "$OUT/dugo/tilt" 1000; "$OUT/obj_frame1000/tb" > "$OUT/tb_f4_frame1000.log"
python3 f4/mkref.py "$OUT/dugo/tilt" 7 1000 "$OUT/ref_tilt.txt"; cmp "$OUT/ref_tilt.txt" f4/ref_tilt.txt && echo "ref = f4/ref_tilt.txt"
echo "=== 2d: slucajno pocetno stanje (6 sjemena)"
$VL --x-initial unique --x-assign unique --timescale 1ns/1ps --top-module tb_f4_frame -GNFRAMES=12 -GPREFIX="\"$OUT/xr\"" \
  --Mdir "$OUT/obj_xr" -o tb $NES f4/f4_frame_crc.v sim/f4/tb_f4_frame.v 2>&1 | grep -E "%Error" -A3 || true
for s in 1 2 3 4 5 6; do echo "sjeme $s: $("$OUT/obj_xr/tb" +verilator+rand+reset+2 +verilator+seed+$s | grep 'KADAR 12')"; done | tee "$OUT/xr.log"
echo "=== 3: cijeli f4_top"
$VL --timescale 1ps/1fs --top-module tb_f4_top --Mdir "$OUT/obj_top" -o tb sim/f1/gm_sim_models.v "$OSS/share/yosys/gatemate/cells_sim.v" \
  $PL/gm_rst_sync.v $PL/gm_div5.v $PL/gm_clkdiv.v $PL/gm_sdram_clk.v $PL/gm_clocks.v $PL/gm_tmds_enc.v $PL/gm_dvi_phy.v $PL/gm_dvi.v \
  framebuffer.v vga.v $NES f4/f4_frame_crc.v f1/f1_uart_tx.v f4/f4_top.v sim/f4/tb_f4_top.v 2>&1 | grep -E "%Error" -A3 || true
"$OUT/obj_top/tb" > "$OUT/tb_f4_top.log" 2>&1; grep -E "UART|PASS" "$OUT/tb_f4_top.log"
echo "=== 4: netlist nakon synth_gatemate"
sim/f4/run_f4_gatesim.sh nes 8 > "$OUT/gatesim.log" 2>&1; grep KADAR "$OUT/gatesim.log" | tail -2
grep KADAR build/f4/gatesim/nes/tb.log | awk '{print $2,$4}' > "$OUT/gate_crc.txt"
grep KADAR "$OUT/tb_f4_frame.log" | head -8 | awk '{print $2,$4}' > "$OUT/rtl_crc.txt"
cmp "$OUT/gate_crc.txt" "$OUT/rtl_crc.txt" && echo "netlist = RTL (CRC kadrova 1..8)"

echo "=== SAZETAK"
grep -q "PODUDARNO: 8991/8991" "$OUT/cmp_nes_div6.log" && grep -q "PODUDARNO: 8991/8991" "$OUT/cmp_nes_div12.log" \
 && grep -q "krivih piksela ukupno 0" "$OUT/cmp_emu_poke.log" && grep -q "krivih piksela ukupno 0" "$OUT/cmp_emu_start.log" \
 && [ "$(grep -c e23ac89a "$OUT/xr.log")" = 6 ] && grep -q "PASS 8 FAIL 0" "$OUT/tb_f4_top.log" \
 && cmp -s "$OUT/gate_crc.txt" "$OUT/rtl_crc.txt" && echo "VRATA 1: PASS" || { echo "VRATA 1: FAIL"; exit 1; }
