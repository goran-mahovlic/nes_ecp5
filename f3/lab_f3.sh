#!/usr/bin/env bash
# F3 vrata 2 (TASK-6070): ucitaj f3_top.bit u SRAM ULX5M-GS (`fpga-jtag gs -r`, bez
# power-cyclea) i procitaj UART (by-id) N sekundi. Izlaz: build/f3/<ime>/lab_<ts>.log
#   f3/lab_f3.sh [ime] [sekundi]
set -euo pipefail
ROOT=$(cd "$(dirname "$0")/.." && pwd)
ime=${1:-nestest}; SEK=${2:-8}
BIT=$ROOT/build/f3/$ime/f3_top.bit
PI=${PI:-pi@192.168.10.14}   # korisnik pi: gs.owner i ~/ulx5m-serdes su njegovi
RD=ulx5m-serdes/t6070
TS=$(date +%Y%m%d_%H%M%S)
LOG=$ROOT/build/f3/$ime/lab_$TS.log
python3 "$HOME/.claude/regoc/tools/fpga/gm_cfgrst_check.py" "$BIT"
ssh -o BatchMode=yes "$PI" "mkdir -p ~/$RD"
scp -q "$BIT" "$PI:~/$RD/f3_top.bit"
ssh -o BatchMode=yes "$PI" "bash -s" <<REMOTE | tee "$LOG"
set -e
OUT=\$HOME/$RD/run_$TS.out
if [ -s /home/pi/gs.owner ]; then echo "ZAUZETO: \$(cat /home/pi/gs.owner)"; exit 3; fi
echo "TASK-6070 \$(date +%s) F3 nestest (jelena) pid=\$\$ log=\$OUT" > /home/pi/gs.owner
trap 'grep -q "TASK-6070" /home/pi/gs.owner 2>/dev/null && rm -f /home/pi/gs.owner' EXIT
U=\$(fpga-jtag uart gs)
echo "STEP 1/3 sha \$(sha256sum \$HOME/$RD/f3_top.bit | cut -c1-16) uart=\$U" | tee \$OUT
stty -F "\$U" 115200 raw -echo
echo "STEP 2/3 load fpga-jtag gs \$HOME/$RD/f3_top.bit -r" | tee -a \$OUT
fpga-jtag gs "\$HOME/$RD/f3_top.bit" -r 2>&1 | tail -4 | tee -a \$OUT
echo "STEP 3/3 uart $SEK s" | tee -a \$OUT
timeout $SEK cat "\$U" | tr -d '\0' | tee -a \$OUT || true
REMOTE
echo "log: $LOG"
