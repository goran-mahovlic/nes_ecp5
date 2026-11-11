#!/usr/bin/env python3
"""F4 (TASK-6071): kadar iz simulacije (61440 boja 0..63, hex po retku) -> PNG/PPM 256x240 s paletom iz vga.v.
   f4/frame2png.py kadar.hex izlaz.png|izlaz.ppm"""
import re, sys
from pathlib import Path
import numpy as np
from PIL import Image
ROOT = Path(__file__).resolve().parent.parent

def nes_palette():
    s = (ROOT / "vga.v").read_text()
    p = {int(a, 2): int(b, 16) for a, b in re.findall(r"6'b([01]{6})\s*:\s*begin\s*rgb <= 24'h([0-9A-Fa-f]{6})", s)}
    assert len(p) == 64
    return np.array([((p[k] >> 16) & 255, (p[k] >> 8) & 255, p[k] & 255) for k in range(64)], np.uint8)

def load_idx(path):
    v = [int(l, 16) for l in Path(path).read_text().split()]
    assert len(v) == 61440, len(v)
    return np.array(v, np.uint8).reshape(240, 256)

if __name__ == "__main__":
    Image.fromarray(nes_palette()[load_idx(sys.argv[1])]).save(sys.argv[2])
