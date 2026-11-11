#!/usr/bin/env bash
# F2 vrata 2 (TASK-6069): ucitaj bit u SRAM ULX5M-GS (`fpga-jtag gs -r`, bez power-cyclea),
# pricekaj snimac MS2109 i automatski provjeri kadar (f2/check_frame.py) -> PASS/FAIL.
#   f2/lab_f2.sh <bit> [spec f2|litex] [broj_ucitavanja=3] [ime]
#   CTRL_BIT=<bit bez DVI-ja> -> prije svakog ucitavanja kontrola: snimac MORA pasti na "nema
#   signala" (dokaz da snap.jpg nije zastarjeli okvir), tek onda <bit> mora dati PASS.
# Kadar: curl http://192.168.10.14:8090/snap.jpg (servis hdmi_stream.py drzi /dev/video0 --
# uredjaj se NE otvara izravno). Zakup ploce: /home/pi/gs.owner (korisnik pi).
# Izlaz: build/f2/lab/<ime>_<ts>/ (snap_<i>_<j>.jpg, check_<i>_<j>.json, lab.log); izlaz 0 = svi PASS.
set -uo pipefail
ROOT=$(cd "$(dirname "$0")/.." && pwd)
BIT=$1; SPEC=${2:-f2}; N=${3:-3}; ime=${4:-$(basename "$BIT" .bit)}
PI=${PI:-pi@192.168.10.14}; SNAP=${SNAP:-http://192.168.10.14:8090/snap.jpg}
WAIT=${WAIT:-6}; SNAPS=${SNAPS:-3}
TS=$(date +%Y%m%d_%H%M%S); OUT=$ROOT/build/f2/lab/${ime}_$TS; mkdir -p "$OUT"
LOG=$OUT/lab.log
python3 "$HOME/.claude/regoc/tools/fpga/gm_cfgrst_check.py" "$BIT" | tee "$LOG"
sha256sum "$BIT" | tee -a "$LOG"
ssh -o BatchMode=yes "$PI" "mkdir -p ~/ulx5m-serdes/t6069"
scp -q "$BIT" "$PI:~/ulx5m-serdes/t6069/$ime.bit"
ssh -o BatchMode=yes "$PI" 'ls /dev/v4l/by-id/usb-MACROSILICON_2109-video-index0 >/dev/null && systemctl is-active hdmi-stream' 2>&1 | tee -a "$LOG"
CTRL_BIT=${CTRL_BIT:-}
[ -n "$CTRL_BIT" ] && scp -q "$CTRL_BIT" "$PI:~/ulx5m-serdes/t6069/kontrola.bit"
load() {   # $1 = ime .bit na Piju
  ssh -o BatchMode=yes "$PI" "bash -s" <<REMOTE 2>&1 | tee -a "$LOG"
if [ -s /home/pi/gs.owner ]; then echo "ZAUZETO: \$(cat /home/pi/gs.owner)"; exit 3; fi
echo "TASK-6069 \$(date +%s) F2 DVI $1 (jelena)" > /home/pi/gs.owner
fpga-jtag gs "\$HOME/ulx5m-serdes/t6069/$1" -r 2>&1 | tail -1
rm -f /home/pi/gs.owner
REMOTE
}
rc=0
for i in $(seq 1 "$N"); do
  if [ -n "$CTRL_BIT" ]; then
    echo "== kontrola $i/$N: fpga-jtag gs kontrola.bit -r (bez DVI-ja)" | tee -a "$LOG"
    load kontrola.bit; sleep "$WAIT"
    f=$OUT/kontrola_$i.jpg
    curl -s -o "$f" -w "  kontrola $i HTTP %{http_code} %{size_download} B\n" "$SNAP" | tee -a "$LOG"
    ko=$(python3 "$ROOT/f2/check_frame.py" --spec "$SPEC" "$f" 2>&1 || true)   # izlaz 1 je ovdje ocekivan
    if grep -q "NEMA SIGNALA" <<<"$ko"; then
      echo "  kontrola $i: NEMA SIGNALA (ocekivano)" | tee -a "$LOG"
    else
      echo "  kontrola $i: KRIVO - snimac i dalje daje sliku (zastarjeli okvir?)" | tee -a "$LOG"; rc=1
    fi
  fi
  echo "== ucitavanje $i/$N: fpga-jtag gs $ime.bit -r" | tee -a "$LOG"
  load "$ime.bit"
  sleep "$WAIT"
  for j in $(seq 1 "$SNAPS"); do
    f=$OUT/snap_${i}_$j.jpg
    curl -s -o "$f" -w "  snap $i/$j HTTP %{http_code} %{size_download} B\n" "$SNAP" | tee -a "$LOG"
    python3 "$ROOT/f2/check_frame.py" --spec "$SPEC" --json "$OUT/check_${i}_$j.json" "$f" >> "$LOG" 2>&1 || rc=1
    tail -1 "$LOG"
    sleep 1
  done
done
echo "lab: $OUT  rezultat: $([ $rc = 0 ] && echo PASS || echo FAIL)" | tee -a "$LOG"
exit $rc
