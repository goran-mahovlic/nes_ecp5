#!/usr/bin/env python3
"""F4 (TASK-6071): kadrovi PPU-a iz simulacije (f4/frame2png.py oblik, <prefix>_NN.hex) prema emulatoru cynes.
   cmp_emu.py igra.nes build/f4/sim/tilt N [--poke 0x0701=1@3]
Usporedba ne ovisi o paleti: nas indeks boje (0..63) -> boja emulatora mora biti FUNKCIJA (svaki nas
indeks uvijek ista RGB boja emulatora); krivi pikseli = oni koji odstupaju od najcesce boje svog indeksa.
Obrnuti smjer se ne broji jer paleta cynes ima iste RGB za razlicite indekse (npr. 0x20 = 0x30 bijelo).
Jednolik kadar (samo jedna boja) se ne smatra dokazom (ispis 'jednolik').
--poke ADR=VRIJ@KADAR: upis u RAM emulatora nakon kadra (Super Tilt Bro: $0701 = NTSC, v. docs/F4.md).
Faza pokretanja cynes nije stalna (isti ROM daje promjene kadrova u 4,5,6,9.. ili 5,6,7,10..), pa se
nas kadar N usporeduje s emu kadrom N+pomak, uz JEDAN globalni pomak iz -2..2 (onaj s najmanje krivih).
cynes nije u sustavnom pythonu: venv (pip install cynes numpy pillow), v. docs/F4.md."""
import argparse, sys
from pathlib import Path
import numpy as np
import cynes
sys.path.insert(0, str(Path(__file__).resolve().parent))
from frame2png import load_idx

def bad_pixels(ours, emu):
    o = ours.reshape(-1); r = emu.reshape(-1, 3)
    exp = np.zeros_like(r)
    for k in np.unique(o):
        cols, cnt = np.unique(r[o == k], axis=0, return_counts=True)
        exp[o == k] = cols[cnt.argmax()]
    return int((exp != r).any(axis=1).sum()), len(np.unique(o))

ap = argparse.ArgumentParser()
ap.add_argument("rom"); ap.add_argument("prefix"); ap.add_argument("n", type=int)
ap.add_argument("--poke", action="append", default=[])
ap.add_argument("--tipke", help="MASKA@OD:DO -- kontroler emulatora u kadrovima [OD, DO), kao tb_f4_frame BUTTONS/BTN_FROM/BTN_TO")
ap.add_argument("--od", type=int, default=1, help="usporedi od kadra (pokretanje emulatora nije stalno)")
a = ap.parse_args()
pokes = []
for p in a.poke:
    av, f = p.split("@"); ad, v = av.split("=")
    pokes.append((int(f), int(ad, 0), int(v, 0)))
nes = cynes.NES(a.rom)
ours = {i: load_idx(f"{a.prefix}_{i:02d}.hex") for i in range(1, a.n + 1) if Path(f"{a.prefix}_{i:02d}.hex").exists()}
tm, tf, tt = (0, 0, 0)
if a.tipke:
    m_, r_ = a.tipke.split("@"); tm = int(m_, 0); tf, tt = (int(x) for x in r_.split(":"))
    # nasa maska = redoslijed citanja $4016 {R,L,D,U,Start,Select,B,A} (bit 0 = A); cynes ima obrnuti
    # redoslijed (bit 7 = A): izmjereno -- 0x08 (Up u cynes) ne pomakne naslovni ekran, svi ostali da
    tm = int(f"{tm:08b}"[::-1], 2)
emu = []
def step(i, btn):
    nes.controller = btn
    emu.append(nes.step().copy())
    for f, ad, v in pokes:
        if f == i: print(f"poke ${ad:04X}: {nes[ad]} -> {v} (nakon kadra {i})"); nes[ad] = v
def run(off, upto=None):
    return [(i, *bad_pixels(o, emu[i + off - 1])) for i, o in ours.items()
            if i >= a.od and (upto is None or i <= upto) and 1 <= i + off <= len(emu)]
# 1) bez tipki do kadra tf (ili do kraja): pomak faze emulatora iz kadrova prije pritiska
n1 = tf if a.tipke else a.n + 2
for i in range(1, n1 + 1): step(i, 0)
best = min(range(-2, 3), key=lambda off: sum(b for _, b, _ in run(off, n1 - 2)))
# 2) ostatak: tb pritisne tipke dok je broj ZAVRSENIH nasih kadrova u [tf, tt); nas kadar n = emu kadar n+pomak
for i in range(n1 + 1, a.n + 3): step(i, tm if tf <= i - best - 1 < tt else 0)
print(f"pomak kadra (emu = nas + pomak): {best}")
tot_bad = 0; uni = 0; ok = 0
for i, bad, ncol in run(best):
    tot_bad += bad
    if ncol == 1: uni += 1; tag = "jednolik"
    else: ok += bad == 0; tag = "ISTO" if bad == 0 else "RAZLIKA"
    print(f"kadar {i:3d}: krivih {bad:5d}  boja {ncol:2d}  {tag}")
print(f"UKUPNO: kadrova s 0 krivih (nejednolikih) {ok}, jednolikih {uni}, krivih piksela ukupno {tot_bad}")
sys.exit(0 if tot_bad == 0 else 1)
