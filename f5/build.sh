#!/usr/bin/env bash
# F5 (TASK-6072): sinteza + P&R + gmpack --reset za f5_top (NES + DVI + USB HID host) na ULX5M-GS (CCGM1A1).
#   f5/build.sh [ime]   -> build/f5/<ime>/f5_top.bit (+ synth.log, pnr.log, stat.txt, sha256.txt)
# Lanac kao F1-F3: oss-cad-suite-20261016, fpga_mode=2 (ECONOMY), --freq 25; t65 iz t65/t65_ghdl.v.
# Bez cart.sv (49 mappera): nes.v CART_NROM -> f4/cart_nrom.v. SEED=<n> za drugi smjestaj.
# DECODER=0 (zadano) USB tipkovnica, DECODER=1 NES USB dzojstik (Emard; Goranov kontroler 12.11.).
set -euo pipefail
ROOT=$(cd "$(dirname "$0")/.." && pwd); cd "$ROOT"
ime=${1:-tilt}
OUT=${F5_OUT:-$ROOT/build/f5}/$ime; mkdir -p "$OUT"
OSS=${OSS_GM:-$HOME/app/raid/tools/oss-cad-suite-20261016}
export PATH=$OSS/bin:$PATH
SEED=${SEED:-1}
DECODER=${DECODER:-0}
PL=platform/gatemate
SRC="$PL/gm_rst_sync.v $PL/gm_div5.v $PL/gm_clkdiv.v $PL/gm_sdram_clk.v $PL/gm_clocks.v \
     $PL/gm_tmds_enc.v $PL/gm_dvi_phy.v $PL/gm_dvi.v framebuffer.v vga.v \
     t65/t65_ghdl.v nes.v ppu.sv apu.sv palette_ram.v f4/cart_nrom.v f4/f4_nes_sys.v \
     f4/f4_frame_crc.v f1/f1_uart_tx.v \
     f5/f5_report_decoder_kbd.v usb/report_decoder/usbh_report_decoder_nes.v f5/f5_hid_buttons.v \
     usb/usbhost/usbh_host_hid.v usb/usbhost/usbh_crc5.v usb/usbhost/usbh_crc16.v f5/usbhost/usbh_sie.v \
     f5/usbhost/usb_phy_ghdl.v f5/f5_usb_joy.v f5/f5_top.v"
yosys -q -l "$OUT/synth.log" \
  -p "read_verilog -defer -sv $SRC" -p "hierarchy -top f5_top -chparam DECODER $DECODER" \
  -p "synth_gatemate -top f5_top -luttree -nomx8" -p "opt_clean" \
  -p "write_json $OUT/f5.json" -p "tee -q -o $OUT/stat.txt stat"
nextpnr-himbaechel --device CCGM1A1 --json "$OUT/f5.json" --seed "$SEED" \
  --freq 25 -o ccf=$PL/ulx5m_gs.ccf -o fpga_mode=2 -o out="$OUT/f5.txt" \
  --timing-allow-fail -l "$OUT/pnr.log" >/dev/null 2>&1
gmpack --reset --input "$OUT/f5.txt" --bit "$OUT/f5_top.bit" 2>&1 | tee "$OUT/gmpack.log"
python3 "$HOME/.claude/regoc/tools/fpga/gm_cfgrst_check.py" "$OUT/f5_top.bit"
sha256sum "$OUT/f5_top.bit" | tee "$OUT/sha256.txt"
grep -E "Max frequency for clock|Used more|ERROR|FAIL" "$OUT/pnr.log" || true
echo "gotovo: $OUT"
