#!/usr/bin/env python3
"""F4 (TASK-6071): referenca kadra za check_frame.py --spec f4 iz kadrova simulacije.
   f4/mkref.py build/f4/sim/tilt 7 120 f4/ref_tilt.txt
Piksel koji je jednak u SVIM kadrovima od..do (stalni dio slike) zapisuje se kao boja (hex 00..3F);
piksel koji se mijenja (oblaci se micu) kao '--' i provjera ga preskace. 61440 redaka, y pa x."""
import sys
from pathlib import Path
import numpy as np
sys.path.insert(0, str(Path(__file__).resolve().parent))
from frame2png import load_idx
pre, a, b, out = sys.argv[1], int(sys.argv[2]), int(sys.argv[3]), sys.argv[4]
fr = np.stack([load_idx(f"{pre}_{i:02d}.hex") for i in range(a, b + 1)])
static = (fr == fr[0]).all(axis=0)
ref = fr[-1]
Path(out).write_text("".join(f"{c:02x}\n" if s else "--\n" for c, s in zip(ref.reshape(-1), static.reshape(-1))))
print(f"{out}: kadrovi {a}..{b} ({len(fr)}), stalnih piksela {int(static.sum())}/61440, boje {sorted(set(ref[static].tolist()))}")
