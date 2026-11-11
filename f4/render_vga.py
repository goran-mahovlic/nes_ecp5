#!/usr/bin/env python3
"""F4 (TASK-6071): kadar simulacije (256x240 indeksi) -> ocekivani 640x480 izlaz vga.v (2x, prozor 65..575),
boje iz palete vga.v. Za sinteticke testove check_frame.py --spec f4.
   f4/render_vga.py kadar.hex izlaz.png [jpeg_kvaliteta]"""
import sys
from pathlib import Path
import numpy as np
from PIL import Image
sys.path.insert(0, str(Path(__file__).resolve().parent))
from frame2png import load_idx, nes_palette

def render(idx):
    img = np.zeros((480, 640, 3), np.uint8)
    nes = nes_palette()[idx]
    img[:, 65:65 + 512] = nes.repeat(2, axis=0).repeat(2, axis=1)
    img[:, 576] = 0     # vga.v: picture = hcnt > 64 && hcnt < 576 -> 511 stupaca (65..575)
    return img

if __name__ == "__main__":
    im = Image.fromarray(render(load_idx(sys.argv[1])))
    if len(sys.argv) > 3: im.save(sys.argv[2], quality=int(sys.argv[3]))
    else: im.save(sys.argv[2])
