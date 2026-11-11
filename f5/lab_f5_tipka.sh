#!/usr/bin/env bash
# F5 vrata 3, dio B (TASK-6072): pritisak na USB tipkovnici/dzojstiku na J5 -> NES prelazi s naslova u izbornik OPTIONS.
# Na Piju (setsid, prezivi prekid ssh-a): zakup gs.owner -> fpga-jtag gs f5_top.bit -r -> 3 kadra "prije" -> UART dok se
# ne pojavi redak s J != 00 (tipka NES-a s USB-a, OR kroz sekundu) ili istekne TMAX s -> 4 s -> 3 kadra "poslije" -> gotovo.
# Lokalno: ceka oznaku gotovo, kopira i provjerava:
#   prije  : check_frame --spec f4 --ref f4/ref_tilt.txt      PASS (naslovni ekran)
#   poslije: check_frame --spec f4 --ref f5/ref_options.txt   PASS (izbornik OPTIONS, sim tb_f4_frame Start, kadrovi 150..400)
#            i --ref f4/ref_tilt.txt FAIL (kadar se promijenio)
#   UART   : prije pritiska CRC = sim (check_uart --usb-enum: uredaj enumeriran, L[1:0]=2), pritisak J != 00
#   f5/lab_f5_tipka.sh [ime=kbd_s1] [TMAX=10800]     izlaz: build/f5/lab/tipka_<ime>_<ts>/ (REZULTAT.txt), rc 0 = PASS
set -uo pipefail
ROOT=$(cd "$(dirname "$0")/.." && pwd)
ime=${1:-kbd_s1}; TMAX=${2:-10800}
BIT=$ROOT/build/f5/$ime/f5_top.bit
SIMLOG=${SIMLOG:-$ROOT/build/f4/sim/tb_f4_frame1000.log}
PI=${PI:-pi@192.168.10.14}; TS=$(date +%Y%m%d_%H%M%S); RD=ulx5m-serdes/t6072/tipka_$TS
OUT=$ROOT/build/f5/lab/tipka_${ime}_$TS; mkdir -p "$OUT"; LOG=$OUT/lab.log
sha256sum "$BIT" | tee "$LOG"
ssh -o BatchMode=yes "$PI" "mkdir -p ~/$RD" && scp -q "$BIT" "$PI:~/$RD/f5_top.bit" || { echo "ssh/scp FAIL" | tee -a "$LOG"; exit 1; }
ssh -o BatchMode=yes "$PI" "cat > ~/$RD/tipka.sh" <<REMOTE
#!/usr/bin/env bash
D=\$HOME/$RD; cd \$D
if [ -s /home/pi/gs.owner ]; then echo "ZAUZETO: \$(cat /home/pi/gs.owner)" > stanje.txt; echo ZAUZETO > gotovo; exit 3; fi
echo "TASK-6072 \$(date +%s) F5 USB tipka $ime (jelena, ceka pritisak do $TMAX s) pid=\$\$" > /home/pi/gs.owner
trap 'grep -q "TASK-6072" /home/pi/gs.owner 2>/dev/null && rm -f /home/pi/gs.owner' EXIT
U=\$(fpga-jtag uart gs); stty -F "\$U" 115200 raw -echo; timeout 1 cat "\$U" > /dev/null || true
( timeout $TMAX cat "\$U" | tr -d '\0' > uart.log ) & CP=\$!
fpga-jtag gs f5_top.bit -r > load.txt 2>&1
sleep 8
for j in 1 2 3; do curl -s -o prije_\$j.jpg http://127.0.0.1:8090/snap.jpg; sleep 1; done
echo "ceka pritisak od \$(date +%T)" > stanje.txt
t0=\$(date +%s); hit=0
while [ \$(( \$(date +%s) - t0 )) -lt $TMAX ]; do
  if grep -aE '^F5 .* J=([0-9A-F][1-9A-F]|[1-9A-F][0-9A-F]) ' uart.log > /dev/null 2>&1; then hit=1; break; fi
  sleep 1
done
if [ \$hit = 1 ]; then
  echo "pritisak \$(date +%T)" >> stanje.txt; sleep 4
  for j in 1 2 3; do curl -s -o poslije_\$j.jpg http://127.0.0.1:8090/snap.jpg; sleep 1; done
  sleep 3
else echo "TMAX bez pritiska" >> stanje.txt; fi
kill \$CP 2>/dev/null; pkill -P \$CP 2>/dev/null
echo \$hit > gotovo
REMOTE
ssh -o BatchMode=yes "$PI" "chmod +x ~/$RD/tipka.sh; setsid nohup ~/$RD/tipka.sh > ~/$RD/tipka.out 2>&1 < /dev/null & echo pi_pid=\$!" | tee -a "$LOG"
echo "ceka $TMAX s na pritisak (Pi: ~/$RD)" | tee -a "$LOG"
end=$(( $(date +%s) + TMAX + 600 ))
while [ "$(date +%s)" -lt $end ]; do
  ssh -o BatchMode=yes -o ConnectTimeout=10 "$PI" "test -f ~/$RD/gotovo" 2>/dev/null && break
  sleep 20
done
scp -q "$PI:~/$RD/*" "$OUT/" 2>/dev/null; rm -f "$OUT/f5_top.bit"
cat "$OUT/stanje.txt" 2>/dev/null | tee -a "$LOG"
rc=0
hit=$(cat "$OUT/gotovo" 2>/dev/null || echo nema)
[ "$hit" = 1 ] || { echo "nema pritiska (gotovo=$hit)" | tee -a "$LOG"; rc=2; }
for j in 1 2 3; do
  [ -f "$OUT/prije_$j.jpg" ] || continue
  r=$(python3 "$ROOT/f2/check_frame.py" --spec f4 --ref "$ROOT/f4/ref_tilt.txt" --json "$OUT/prije_${j}_tilt.json" "$OUT/prije_$j.jpg" 2>&1 | tail -1) || rc=1
  echo "prije $j (naslov, ref_tilt): $r" | tee -a "$LOG"
done
for j in 1 2 3; do
  [ -f "$OUT/poslije_$j.jpg" ] || continue
  r=$(python3 "$ROOT/f2/check_frame.py" --spec f4 --ref "$ROOT/f5/ref_options.txt" --json "$OUT/poslije_${j}_options.json" "$OUT/poslije_$j.jpg" 2>&1 | tail -1) || rc=1
  echo "poslije $j (OPTIONS, ref_options): $r" | tee -a "$LOG"
  if python3 "$ROOT/f2/check_frame.py" --spec f4 --ref "$ROOT/f4/ref_tilt.txt" "$OUT/poslije_$j.jpg" > /dev/null 2>&1; then
    echo "poslije $j: KRIVO - jos uvijek naslovni ekran" | tee -a "$LOG"; rc=1
  else echo "poslije $j: naslov FAIL (ocekivano, kadar se promijenio)" | tee -a "$LOG"; fi
done
grep -aE '^F5 ' "$OUT/uart.log" 2>/dev/null | tee "$OUT/uart_f5.log" | tail -8 | tee -a "$LOG"
python3 "$ROOT/f4/check_uart.py" --usb-enum "$SIMLOG" "$OUT/uart_f5.log" | tail -6 | tee -a "$LOG"; [ "${PIPESTATUS[0]}" = 0 ] || rc=1
echo "REZULTAT: $([ $rc = 0 ] && echo PASS || echo "FAIL rc=$rc")  $OUT" | tee -a "$LOG" "$OUT/REZULTAT.txt"
exit $rc
