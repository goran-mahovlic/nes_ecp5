#!/usr/bin/env bash
# F5 vrata 3 (TASK-6072), dio A (bez covjeka): N x [kontrola bez DVI-ja -> "nema signala"] -> fpga-jtag gs f5_top.bit -r
# (SRAM, bez power-cyclea, zakup /home/pi/gs.owner) + UART SEK s + 3 kadra -> check_frame --spec f4 (ref_tilt: DVI i NES
# rade kao F4) + check_uart.py (CRC kadrova = sim; polje L = stanje USB hosta).
#   f5/lab_f5.sh [ime=kbd_s3] [N=3] [SEK=16]      izlaz: build/f5/lab/<ime>_<ts>/, rc 0 = sve PASS
# check_uart --bez-tipke (U=0000, J=00: nitko ne tipka). USB_ENUM=1 -> i --usb-enum (L[1:0] = 2: uredaj na J5 enumeriran). Bit ostaje ucitan nakon zadnjeg kruga.
set -uo pipefail
ROOT=$(cd "$(dirname "$0")/.." && pwd)
ime=${1:-kbd_s3}; N=${2:-3}; SEK=${3:-16}
BIT=$ROOT/build/f5/$ime/f5_top.bit
CTRL_BIT=${CTRL_BIT:-$ROOT/build/f1/clkmeter/f1_clkmeter.bit}
REF=${REF:-$ROOT/f4/ref_tilt.txt}; SIMLOG=${SIMLOG:-$ROOT/build/f4/sim/tb_f4_frame1000.log}
PI=${PI:-pi@192.168.10.14}; RD=ulx5m-serdes/t6072
WAIT=${WAIT:-8}; SNAPS=${SNAPS:-3}
TS=$(date +%Y%m%d_%H%M%S); OUT=$ROOT/build/f5/lab/${ime}_$TS; mkdir -p "$OUT"
LOG=$OUT/lab.log
python3 "$HOME/.claude/regoc/tools/fpga/gm_cfgrst_check.py" "$BIT" | tee "$LOG"
sha256sum "$BIT" | tee -a "$LOG"
ssh -o BatchMode=yes "$PI" "mkdir -p ~/$RD"
scp -q "$BIT" "$PI:~/$RD/f5_top.bit"; scp -q "$CTRL_BIT" "$PI:~/$RD/kontrola.bit"
rc=0
for i in $(seq 1 "$N"); do
  echo "== ucitavanje $i/$N" | tee -a "$LOG"
  ssh -o BatchMode=yes "$PI" "bash -s" <<REMOTE 2>&1 | tee -a "$LOG"
set -e
D=\$HOME/$RD/run_${TS}_$i; mkdir -p \$D
if [ -s /home/pi/gs.owner ]; then echo "ZAUZETO: \$(cat /home/pi/gs.owner)"; exit 3; fi
echo "TASK-6072 \$(date +%s) F5 NES USB $ime (jelena) pid=\$\$" > /home/pi/gs.owner
trap 'grep -q "TASK-6072" /home/pi/gs.owner 2>/dev/null && rm -f /home/pi/gs.owner' EXIT
U=\$(fpga-jtag uart gs)
echo "kontrola: fpga-jtag gs kontrola.bit -r (bez DVI-ja)"
fpga-jtag gs "\$HOME/$RD/kontrola.bit" -r 2>&1 | tail -1
sleep $WAIT
curl -s -o \$D/kontrola.jpg -w "kontrola HTTP %{http_code} %{size_download} B\n" http://127.0.0.1:8090/snap.jpg
stty -F "\$U" 115200 raw -echo
timeout 1 cat "\$U" > /dev/null || true
( timeout $SEK cat "\$U" | tr -d '\0' > \$D/uart.log ) &
echo "STEP load fpga-jtag gs f5_top.bit -r sha \$(sha256sum \$HOME/$RD/f5_top.bit | cut -c1-16) uart=\$U"
fpga-jtag gs "\$HOME/$RD/f5_top.bit" -r 2>&1 | tail -1
sleep $WAIT
for j in \$(seq 1 $SNAPS); do
  curl -s -o \$D/snap_\$j.jpg -w "snap \$j HTTP %{http_code} %{size_download} B\n" http://127.0.0.1:8090/snap.jpg
  sleep 1
done
wait
REMOTE
  [ "${PIPESTATUS[0]}" = 0 ] || { echo "ucitavanje $i: ssh/zakup FAIL" | tee -a "$LOG"; rc=1; continue; }
  T=$OUT/t$i; mkdir -p "$T"; scp -q "$PI:~/$RD/run_${TS}_$i/*" "$T/"
  mv "$T/kontrola.jpg" "$OUT/kontrola_$i.jpg"; mv "$T/uart.log" "$OUT/uart_$i.log"
  for j in $(seq 1 "$SNAPS"); do mv "$T/snap_$j.jpg" "$OUT/snap_${i}_$j.jpg"; done; rmdir "$T"
  ko=$(python3 "$ROOT/f2/check_frame.py" --spec f4 --ref "$REF" "$OUT/kontrola_$i.jpg" 2>&1 || true)
  if grep -q "NEMA SIGNALA" <<<"$ko"; then echo "  kontrola $i: NEMA SIGNALA (ocekivano)" | tee -a "$LOG"
  else echo "  kontrola $i: KRIVO - snimac i dalje daje sliku" | tee -a "$LOG"; rc=1; fi
  for j in $(seq 1 "$SNAPS"); do
    r=$(python3 "$ROOT/f2/check_frame.py" --spec f4 --ref "$REF" --json "$OUT/check_${i}_$j.json" "$OUT/snap_${i}_$j.jpg" 2>&1) || rc=1
    echo "$r" | tail -2 | tee -a "$LOG"
  done
  echo "  UART $i:" | tee -a "$LOG"; cat "$OUT/uart_$i.log" | tee -a "$LOG"
done
EN=(--bez-tipke); [ "${USB_ENUM:-0}" = 1 ] && EN+=(--usb-enum)
python3 "$ROOT/f4/check_uart.py" "${EN[@]}" "$SIMLOG" "$OUT"/uart_*.log | tee -a "$LOG" || rc=1
echo "lab: $OUT  rezultat: $([ $rc = 0 ] && echo PASS || echo FAIL)" | tee -a "$LOG"
exit $rc
