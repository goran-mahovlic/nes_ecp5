#!/usr/bin/env python3
"""F4 (TASK-6071): UART s plocice (f4_top) prema simulaciji (sim/f4/tb_f4_frame: "KADAR n CRC c ...").
   f4/check_uart.py build/f4/sim/tb_f4_frame1000.log uart_1.log [uart_2.log ...]
Za svaki redak "F4 T= F= H= G= N= PC= V= I= K=": G (CRC zadnjeg kadra F) = CRC kadra F iz simulacije,
N = 0F000 (61440 piksela), V = 01 (igra prepoznala NTSC, $0701), K = 7 (tipke otpustene),
H = CRC kadra 120 iz simulacije kad je F >= 120 (inace 00000000), I = 3B..3D (NMI ~60/s; u retku T=0001
igra ukljuci NMI tek od kadra 5, pa je tamo dopusteno 30..3D).
Izlaz 0 ako su svi redci OK i svaka datoteka ima bar 3 retka."""
import re, sys
sim = {int(n): c.upper() for n, c in re.findall(r"KADAR (\d+) CRC ([0-9a-fA-F]{8})", open(sys.argv[1]).read())}
R = re.compile(r"F4 T=([0-9A-F]{4}) F=([0-9A-F]{4}) H=([0-9A-F]{8}) G=([0-9A-F]{8}) N=([0-9A-F]{5}) "
               r"PC=([0-9A-F]{4}) V=([0-9A-F]{2}) I=([0-9A-F]{2}) K=([0-9A-F])")
tot_ok = tot_bad = 0; files_ok = True
for path in sys.argv[2:]:
    n = 0
    for line in open(path, errors="replace"):
        m = R.search(line)
        if not m: continue
        t, f, h, g, npx, pc, v, i, k = m.groups(); f = int(f, 16); n += 1
        err = []
        if f not in sim: err.append(f"kadar {f} nije u simulaciji (max {max(sim)})")
        elif g != sim[f]: err.append(f"G {g} != sim {sim[f]}")
        if f >= 120 and h != sim[120]: err.append(f"H {h} != sim kadar 120 {sim[120]}")
        if f < 120 and h != "00000000": err.append(f"H {h} prije kadra 120")
        if npx != "0F000": err.append(f"N {npx}")
        if v != "01": err.append(f"V {v}")
        if k != "7": err.append(f"K {k}")
        if not (0x30 if t == "0001" else 0x3B) <= int(i, 16) <= 0x3D: err.append(f"I {i}")
        print(f"{path.split('/')[-1]} T={t} F={f:4d} G={g} {'OK' if not err else 'RAZLIKA ' + '; '.join(err)}")
        tot_ok += not err; tot_bad += bool(err)
    if n < 3: print(f"{path}: samo {n} redaka"); files_ok = False
print(f"UKUPNO: {tot_ok} OK, {tot_bad} razlika")
sys.exit(0 if tot_bad == 0 and files_ok else 1)
