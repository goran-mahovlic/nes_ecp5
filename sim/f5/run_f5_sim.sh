#!/usr/bin/env bash
# F5 vrata 1 (TASK-6072), verilator iz oss-cad-suite-20261016 (kao F4).
#  1a HID izvjestaj -> tipke (f5_hid_buttons, tipkovnica + Emardov NES dzojstik)        tb_f5_decoder PASS
#  1b Enter (tipkovnica) i Start (NES dzojstik) iz izvjestaja kroz CDC u f4_nes_sys,
#     kadrovi 1..200 -> CRC = tb_f4_frame s BUTTONS=08 u kadrovima 60..69 (F4 vrata 2b)  cmp 0
#  1c kontrola: izvjestaj s krivom tipkom ('a') -> CRC se od kadra ~61 NE poklapa s 2b, ali = bez tipki
#  1d cijeli f5_top (model PLL-a, USB host, UART s poljima J/U/R/L): bez uredaja (DEV=0) i s LS pull-upom na D- (DEV=1)
#  1e isto uz slucajno pocetno stanje registara (--x-initial unique, 6 sjemena): nema laznog izvjestaja (Nalaz 1)
#   sim/f5/run_f5_sim.sh [log_dir]
set -euo pipefail
ROOT=$(cd "$(dirname "$0")/../.." && pwd); cd "$ROOT"
OSS=${OSS_GM:-$HOME/app/raid/tools/oss-cad-suite-20261016}; export PATH=$OSS/bin:$PATH
OUT=${1:-build/f5/sim}; mkdir -p "$OUT"
VL="verilator --binary --timing -j 16 -O3 -Wno-fatal -Wno-lint -Wno-style -Wno-WIDTH -Wno-MULTIDRIVEN -Wno-TIMESCALEMOD"
NES="t65/t65_ghdl.v nes.v ppu.sv apu.sv palette_ram.v f4/cart_nrom.v f4/f4_nes_sys.v"
HID="f5/f5_report_decoder_kbd.v usb/report_decoder/usbh_report_decoder_nes.v f5/f5_hid_buttons.v"
USB="usb/usbhost/usbh_host_hid.v usb/usbhost/usbh_crc5.v usb/usbhost/usbh_crc16.v f5/usbhost/usbh_sie.v f5/usbhost/usb_phy_ghdl.v"
PL=platform/gatemate
python3 f3/mkhex.py rom/game_tilt.nes f4/tilt_prg.hex f4/tilt_chr.hex >/dev/null

echo "=== 1a: HID izvjestaj -> tipke"
$VL --timescale 1ns/1ps --top-module tb_f5_decoder --Mdir "$OUT/obj_dec" -o tb $HID sim/f5/tb_f5_decoder.v 2>&1 | grep -E "%Error" -A3 || true
"$OUT/obj_dec/tb" | tee "$OUT/tb_f5_decoder.log" | tail -1

# referenca F4 2b: BUTTONS=08 u kadrovima 60..69 (isti tb kao F4)
REF2B=$OUT/tb_f4_start.log
if [ ! -s "$REF2B" ]; then
  $VL --timescale 1ns/1ps --top-module tb_f4_frame -GNFRAMES=200 -GPREFIX="\"$OUT/f4s\"" -GBUTTONS=8\'h08 -GBTN_FROM=60 -GBTN_TO=70 \
    --Mdir "$OUT/obj_f4start" -o tb $NES f4/f4_frame_crc.v sim/f4/tb_f4_frame.v 2>&1 | grep -E "%Error" -A3 || true
  "$OUT/obj_f4start/tb" > "$REF2B"; rm -f "$OUT"/f4s_*.hex
fi
$VL --timescale 1ns/1ps --top-module tb_f4_frame -GNFRAMES=200 -GPREFIX="\"$OUT/f4n\"" \
  --Mdir "$OUT/obj_f4none" -o tb $NES f4/f4_frame_crc.v sim/f4/tb_f4_frame.v 2>&1 | grep -E "%Error" -A3 || true
[ -s "$OUT/tb_f4_none.log" ] || { "$OUT/obj_f4none/tb" > "$OUT/tb_f4_none.log"; rm -f "$OUT"/f4n_*.hex; }
crc() { grep '^KADAR' "$1" | awk '{print $2, $4}'; }
crc "$REF2B" > "$OUT/crc_f4_start.txt"; crc "$OUT/tb_f4_none.log" > "$OUT/crc_f4_none.txt"

hidframes() {  # $1 ime, ostalo -G
  local n=$1; shift
  $VL --timescale 1ns/1ps --top-module tb_f5_frame "$@" --Mdir "$OUT/obj_$n" -o tb $NES f4/f4_frame_crc.v $HID sim/f5/tb_f5_frame.v 2>&1 | grep -E "%Error" -A3 || true
  "$OUT/obj_$n/tb" > "$OUT/tb_f5_$n.log"; crc "$OUT/tb_f5_$n.log" > "$OUT/crc_f5_$n.txt"
  echo "$n: $(grep -c '^KADAR' "$OUT/tb_f5_$n.log") kadrova; $(grep '^TIPKE' "$OUT/tb_f5_$n.log" | tr '\n' ';')"
}
echo "=== 1b: tipka iz HID izvjestaja -> kadrovi = F4 2b"
hidframes kbd -GDECODER=0 -GREP_ON=64\'h0000000000280000
cmp "$OUT/crc_f5_kbd.txt" "$OUT/crc_f4_start.txt" && echo "tipkovnica Enter: CRC kadrova 1..200 = F4 2b (cmp 0)"
hidframes joy -GDECODER=1 -GREP_ON=64\'h0020004040000000 -GREP_OFF=64\'h0000004040000000
cmp "$OUT/crc_f5_joy.txt" "$OUT/crc_f4_start.txt" && echo "NES dzojstik Start: CRC kadrova 1..200 = F4 2b (cmp 0)"
echo "=== 1c: kontrola, tipka 'a' (nije mapirana)"
hidframes krivo -GDECODER=0 -GREP_ON=64\'h0000000000040000
cmp -s "$OUT/crc_f5_krivo.txt" "$OUT/crc_f4_start.txt" && echo "KONTROLA KRIVO: 'a' = Start?!" || \
  echo "kontrola: 'a' != F4 2b, prvi razliciti kadar $(diff <(cut -d' ' -f2 "$OUT/crc_f5_krivo.txt") <(cut -d' ' -f2 "$OUT/crc_f4_start.txt") | head -1)"
cmp "$OUT/crc_f5_krivo.txt" "$OUT/crc_f4_none.txt" && echo "kontrola: 'a' = bez tipki (cmp 0)"

echo "=== 1d: cijeli f5_top"
$VL --timescale 1ps/1fs --top-module tb_f5_top --Mdir "$OUT/obj_top" -o tb sim/f1/gm_sim_models.v "$OSS/share/yosys/gatemate/cells_sim.v" \
  $PL/gm_rst_sync.v $PL/gm_div5.v $PL/gm_clkdiv.v $PL/gm_sdram_clk.v $PL/gm_clocks.v $PL/gm_tmds_enc.v $PL/gm_dvi_phy.v $PL/gm_dvi.v \
  framebuffer.v vga.v $NES f4/f4_frame_crc.v f1/f1_uart_tx.v $HID $USB f5/f5_usb_joy.v f5/f5_top.v sim/f5/tb_f5_top.v 2>&1 | grep -E "%Error" -A3 || true
"$OUT/obj_top/tb" > "$OUT/tb_f5_top.log" 2>&1; grep -E "UART|PASS|FAIL" "$OUT/tb_f5_top.log"
$VL --timescale 1ps/1fs --top-module tb_f5_top -GDEV=1 --Mdir "$OUT/obj_top_dev" -o tb sim/f1/gm_sim_models.v "$OSS/share/yosys/gatemate/cells_sim.v" \
  $PL/gm_rst_sync.v $PL/gm_div5.v $PL/gm_clkdiv.v $PL/gm_sdram_clk.v $PL/gm_clocks.v $PL/gm_tmds_enc.v $PL/gm_dvi_phy.v $PL/gm_dvi.v \
  framebuffer.v vga.v $NES f4/f4_frame_crc.v f1/f1_uart_tx.v $HID $USB f5/f5_usb_joy.v f5/f5_top.v sim/f5/tb_f5_top.v 2>&1 | grep -E "%Error" -A3 || true
"$OUT/obj_top_dev/tb" > "$OUT/tb_f5_top_dev.log" 2>&1; echo "DEV=1 (LS uredaj prikljucen):"; grep -E "UART|PASS|FAIL" "$OUT/tb_f5_top_dev.log"

echo "=== 1e: f5_top uz slucajno pocetno stanje registara (Nalaz 1: lazni HID izvjestaj), 6 sjemena"
$VL --x-initial unique --x-assign unique --timescale 1ps/1fs --top-module tb_f5_top --Mdir "$OUT/obj_top_xr" -o tb sim/f1/gm_sim_models.v "$OSS/share/yosys/gatemate/cells_sim.v" \
  $PL/gm_rst_sync.v $PL/gm_div5.v $PL/gm_clkdiv.v $PL/gm_sdram_clk.v $PL/gm_clocks.v $PL/gm_tmds_enc.v $PL/gm_dvi_phy.v $PL/gm_dvi.v \
  framebuffer.v vga.v $NES f4/f4_frame_crc.v f1/f1_uart_tx.v $HID $USB f5/f5_usb_joy.v f5/f5_top.v sim/f5/tb_f5_top.v 2>&1 | grep -E "%Error" -A3 || true
for s in 1 2 3 4 5 6; do echo "sjeme $s: $("$OUT/obj_top_xr/tb" +verilator+rand+reset+2 +verilator+seed+$s 2>&1 | grep -E '^UART' | tail -1 | grep -oE 'J=.. U=.... R=[0-9A-F]+ L=..') $("$OUT/obj_top_xr/tb" +verilator+rand+reset+2 +verilator+seed+$s 2>&1 | grep -E 'PASS')"; done | tee "$OUT/xr.log"

echo "=== SAZETAK"
grep -q "PASS 20 FAIL 0" "$OUT/tb_f5_decoder.log" && cmp -s "$OUT/crc_f5_kbd.txt" "$OUT/crc_f4_start.txt" \
 && cmp -s "$OUT/crc_f5_joy.txt" "$OUT/crc_f4_start.txt" && ! cmp -s "$OUT/crc_f5_krivo.txt" "$OUT/crc_f4_start.txt" \
 && cmp -s "$OUT/crc_f5_krivo.txt" "$OUT/crc_f4_none.txt" && grep -q "PASS .* FAIL 0" "$OUT/tb_f5_top.log" && grep -q "PASS .* FAIL 0" "$OUT/tb_f5_top_dev.log" && [ "$(grep -c 'PASS 20 FAIL 0' "$OUT/xr.log")" = 6 ] \
 && echo "VRATA 1: PASS" || { echo "VRATA 1: FAIL"; exit 1; }
