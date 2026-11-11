#!/usr/bin/env python3
"""Testovi za f2/check_frame.py --spec f4 (TASK-6071): ispravan kadar s GS-a mora proci, krivi pasti.
  python3 f4/test_check_frame_f4.py   -> "N pass, 0 fail", izlaz 0
Ulazi: f4/testdata/snap_gs_f4_ok.jpg (Super Tilt Bro s GS-a, MS2109), snap_gs_f4_zapelo_cpu.jpg (stvarni
kvar: bit prije popravka cpu_tick_count -- PPU tece, CPU zapne na $2002 prije ukljucenja slike, kadar crn),
f2/testdata/snap_no_signal.jpg, docs/f2_logs/snap/gs_f2_ucitavanje1.jpg (F2 testna slika)."""
import subprocess, sys, tempfile
from pathlib import Path
import numpy as np
from PIL import Image

D = Path(__file__).resolve().parent; ROOT = D.parent
CHK = [sys.executable, str(ROOT / "f2" / "check_frame.py"), "--spec", "f4", "--ref", str(D / "ref_tilt.txt")]
OK = D / "testdata" / "snap_gs_f4_ok.jpg"

def run(path):
    return subprocess.run(CHK + [str(path)], capture_output=True, text=True).returncode

def mutated(fn):
    a = np.asarray(Image.open(OK).convert("RGB")).astype(int).copy()
    f = Path(tempfile.mkstemp(suffix=".png")[1]); Image.fromarray(np.clip(fn(a), 0, 255).astype(np.uint8)).save(f); return f

def shift(a): return np.roll(a, 16, axis=1)                  # 8 NES piksela udesno
def shift_v(a): return np.roll(a, 16, axis=0)                # 8 NES redaka dolje
def rgb_to_bgr(a): return a[:, :, ::-1]
def noise(a):
    r = np.random.default_rng(1); m = r.random(a.shape[:2]) < 0.10
    a[m] = r.integers(0, 256, (int(m.sum()), 3)); return a
def half_black(a): a[240:, :] = 0; return a
def no_title(a):            # natpis SUPER TILT BRO. prebojan nebom (krivi CHR / nametable)
    a[56:200, 160:480] = a[300, 100]; return a
def gray(a): g = a.mean(2, keepdims=True); return np.repeat(g, 3, 2)   # emphasis/grayscale bit

cases = [("ispravan kadar s GS-a -> PASS", OK, 0),
         ("bez signala (svi 7) -> FAIL", ROOT / "f2" / "testdata" / "snap_no_signal.jpg", 1),
         ("F2 testna slika -> FAIL", ROOT / "docs" / "f2_logs" / "snap" / "gs_f2_ucitavanje1.jpg", 1),
         ("stvarni kvar: CPU zapeo (crn kadar) -> FAIL", D / "testdata" / "snap_gs_f4_zapelo_cpu.jpg", 1),
         ("pomak 8 NES px vodoravno -> FAIL", mutated(shift), 1),
         ("pomak 8 NES redaka -> FAIL", mutated(shift_v), 1),
         ("R<->B -> FAIL", mutated(rgb_to_bgr), 1),
         ("sum 10 % -> FAIL", mutated(noise), 1),
         ("pola kadra crno -> FAIL", mutated(half_black), 1),
         ("bez natpisa -> FAIL", mutated(no_title), 1),
         ("sivo (grayscale) -> FAIL", mutated(gray), 1)]
npass = nfail = 0
for name, path, want in cases:
    got = run(path)
    ok = (got == 0) == (want == 0)
    npass += ok; nfail += not ok
    print(f"{'ok  ' if ok else 'FAIL'} {name} (izlaz {got})")
print(f"{npass} pass, {nfail} fail")
sys.exit(0 if nfail == 0 else 1)
