#!/usr/bin/env python3
"""Testovi za f2/check_frame.py (TASK-6069): mora prihvatiti ispravan kadar i oboriti krive.
  python3 f2/test_check_frame.py   -> "N pass, 0 fail", izlaz 0
Ulazi: f2/testdata/snap_gs_f2_ok.jpg (pravi kadar s GS-a, MS2109) i snap_no_signal.jpg (6609 B, svi 7)."""
import subprocess, sys, tempfile
from pathlib import Path
import numpy as np
from PIL import Image

D = Path(__file__).resolve().parent
CHK = [sys.executable, str(D / "check_frame.py")]
OK = D / "testdata" / "snap_gs_f2_ok.jpg"
NOSIG = D / "testdata" / "snap_no_signal.jpg"

def run(path, *args):
    return subprocess.run(CHK + list(args) + [str(path)], capture_output=True, text=True).returncode

def mutated(fn):
    a = np.asarray(Image.open(OK).convert("RGB")).copy()
    b = fn(a)
    f = Path(tempfile.mkstemp(suffix=".png")[1]); Image.fromarray(b.astype(np.uint8)).save(f); return f

def swap_bars(a):           # trake 1 i 2 zamijenjene (krivi redoslijed/boja)
    x1, x2 = 65 + 64, 65 + 128
    t = a[:, x1:x1 + 64].copy(); a[:, x1:x1 + 64] = a[:, x2:x2 + 64]; a[:, x2:x2 + 64] = t; return a
def rgb_to_bgr(a): return a[:, :, ::-1]                 # zamijenjeni R i B kanal
def shift(a): return np.roll(a, 40, axis=1)             # slika pomaknuta 40 px
def noise(a):               # TMDS greske bitova: sumne tocke 10 %
    r = np.random.default_rng(1); m = r.random(a.shape[:2]) < 0.10
    a[m] = r.integers(0, 256, (int(m.sum()), 3)); return a
def no_frame(a): a[0:8, :] = 0; return a                # nema gornjeg okvira
def half_black(a): a[240:, :] = 0; return a             # pola kadra crno

cases = [("ispravan kadar s GS-a -> PASS", OK, [], 0),
         ("bez signala (svi 7) -> FAIL", NOSIG, [], 1),
         ("ispravan kadar, spec litex -> FAIL", OK, ["--spec", "litex"], 1),
         ("zamijenjene trake -> FAIL", mutated(swap_bars), [], 1),
         ("R<->B -> FAIL", mutated(rgb_to_bgr), [], 1),
         ("pomak 40 px -> FAIL", mutated(shift), [], 1),
         ("sum 10 % -> FAIL", mutated(noise), [], 1),
         ("bez gornjeg okvira -> FAIL", mutated(no_frame), [], 1),
         ("pola crno -> FAIL", mutated(half_black), [], 1)]
p = f = 0
for name, path, args, want in cases:
    got = run(path, *args)
    good = (got == 0) == (want == 0)
    p += good; f += not good
    print(f"{'ok  ' if good else 'FAIL'} {name} (izlaz {got})")
print(f"{p} pass, {f} fail")
sys.exit(1 if f else 0)
