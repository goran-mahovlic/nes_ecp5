#!/usr/bin/env python3
"""F4 (TASK-6071) / F5 (TASK-6072): UART s plocice (f4_top / f5_top) prema simulaciji (tb_f4_frame: "KADAR n CRC c ...").
   f4/check_uart.py build/f4/sim/tb_f4_frame1000.log uart_1.log [uart_2.log ...]
Za svaki redak "F4 T= F= H= G= N= PC= V= I= K=": G (CRC zadnjeg kadra F) = CRC kadra F iz simulacije,
N = 0F000 (61440 piksela), V = 01 (igra prepoznala NTSC, $0701), K = 7 (tipke otpustene),
H = CRC kadra 120 iz simulacije kad je F >= 120 (inace 00000000), I = 3B..3D (NMI ~60/s; u retku T=0001
igra ukljuci NMI tek od kadra 5, pa je tamo dopusteno 30..3D).
F5 redak ima jos "J= U= R= L=" (tipke NES-a, broj HID izvjestaja, zadnji izvjestaj, LED hosta). Dok je J=00
redak se provjerava kao F4 (U smije rasti: tipkovnica salje izvjestaje i bez tipke); od prvog retka s J != 00 igra vise ne prati
simulaciju bez tipki, pa se G/H vise ne usporeduju: redak se ispise kao "NAKON USB TIPKE" i broji odvojeno.
--bez-tipke: F5 redak s J != 00 je greska (nitko nije tipkao; Nalaz 1 F5: lazni izvjestaj).
--usb-enum: bar jedan F5 redak mora imati L[1:0] = 2 (host u stanju REPORT = uredaj enumeriran), a svaki redak
s tipkom (J != 00) mora biti u REPORT.
Izlaz 0 ako su svi redci OK i svaka datoteka ima bar 3 retka."""
import re, sys
usb_enum = "--usb-enum" in sys.argv
if usb_enum: sys.argv.remove("--usb-enum")
bez_tipke = "--bez-tipke" in sys.argv
if bez_tipke: sys.argv.remove("--bez-tipke")
sim = {int(n): c.upper() for n, c in re.findall(r"KADAR (\d+) CRC ([0-9a-fA-F]{8})", open(sys.argv[1]).read())}
R = re.compile(r"F[45] T=([0-9A-F]{4}) F=([0-9A-F]{4}) H=([0-9A-F]{8}) G=([0-9A-F]{8}) N=([0-9A-F]{5}) "
               r"PC=([0-9A-F]{4}) V=([0-9A-F]{2}) I=([0-9A-F]{2}) K=([0-9A-F])"
               r"(?: J=([0-9A-F]{2}) U=([0-9A-F]{4}) R=([0-9A-F]{16}) L=([0-9A-F]{2}))?")
tot_ok = tot_bad = tot_usb = 0; files_ok = True; enum_seen = False
for path in sys.argv[2:]:
    n = 0; pressed = False
    for line in open(path, errors="replace"):
        m = R.search(line)
        if not m: continue
        t, f, h, g, npx, pc, v, i, k, j, u, rep, led = m.groups(); f = int(f, 16); n += 1
        err = []
        if j is not None:
            in_rep = int(led, 16) & 3 == 2; enum_seen |= in_rep
            if usb_enum and j != "00" and not in_rep: err.append(f"L {led}: tipka bez enumeriranog uredaja")
            if j != "00":
                if bez_tipke: err.append(f"U={u} J={j} R={rep}: HID izvjestaj bez tipkanja")
                else: pressed = True
            if pressed:
                print(f"{path.split('/')[-1]} T={t} F={f:4d} G={g} J={j} U={u} R={rep} L={led} NAKON USB TIPKE"
                      + ("" if not err else " RAZLIKA " + "; ".join(err)))
                tot_usb += 1; tot_bad += bool(err); continue
        if f not in sim: err.append(f"kadar {f} nije u simulaciji (max {max(sim)})")
        elif g != sim[f]: err.append(f"G {g} != sim {sim[f]}")
        if f >= 120 and h != sim[120]: err.append(f"H {h} != sim kadar 120 {sim[120]}")
        if f < 120 and h != "00000000": err.append(f"H {h} prije kadra 120")
        if npx != "0F000": err.append(f"N {npx}")
        if v != "01": err.append(f"V {v}")
        if k != "7": err.append(f"K {k}")
        if not (0x30 if t == "0001" else 0x3B) <= int(i, 16) <= 0x3D: err.append(f"I {i}")
        print(f"{path.split('/')[-1]} T={t} F={f:4d} G={g}" + (f" L={led}" if led else "")
              + f" {'OK' if not err else 'RAZLIKA ' + '; '.join(err)}")
        tot_ok += not err; tot_bad += bool(err)
    if n < 3: print(f"{path}: samo {n} redaka"); files_ok = False
if usb_enum and not enum_seen: print("USB: nijedan redak s L[1:0]=2 (uredaj nije enumeriran)"); tot_bad += 1
elif usb_enum: print("USB: uredaj enumeriran (L[1:0]=2)")
print(f"UKUPNO: {tot_ok} OK, {tot_bad} razlika" + (f", {tot_usb} redaka nakon USB tipke" if tot_usb else ""))
sys.exit(0 if tot_bad == 0 and files_ok and tot_ok > 0 else 1)
