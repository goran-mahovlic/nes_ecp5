#!/usr/bin/env python3
"""F2 (TASK-6069): automatska provjera kadra s HDMI snimaca (ili iz simulacije) -> PASS/FAIL.

  check_frame.py --spec f2     snap.jpg        # nasa testna slika (f2_testpat.v + paleta vga.v)
  check_frame.py --spec litex  snap.jpg        # LiteX_DVI colorbars (referenca snimaca)
  check_frame.py --spec f2 --exact sim.ppm     # kadar iz tb_f2_dvi: piksel po piksel, bez tolerancije
  check_frame.py --spec f4 --ref f4/ref_tilt.txt snap.jpg   # F4 (TASK-6071): kadar NES igre prema simulaciji

Snimac (MS2109, MJPEG 640x480): za svako podrucje (traka, okvir, crni rub) srednja boja
unutrasnjosti (odmak od rubova zbog JPEG/kroma) mora biti NAJBLIZA svojoj ocekivanoj boji od
svih ocekivanih boja, unutar --tol po kanalu (snimac pojacava zasicenje do ~45), a raspon
(std) malen -- TMDS greske bitova daju sumne tocke ili pomaknute boje. "Svi pikseli 7" = nema signala.
Ocekivana slika gradi se iz istog opisa kao f2_testpat.v; boje iz tablice palete u vga.v.
"""
import argparse, json, re, sys
from pathlib import Path
import numpy as np
from PIL import Image

ROOT = Path(__file__).resolve().parent.parent
W, H = 640, 480

def nes_palette():
    s = (ROOT / "vga.v").read_text()
    p = {int(a, 2): int(b, 16) for a, b in re.findall(r"6'b([01]{6})\s*:\s*begin\s*rgb <= 24'h([0-9A-Fa-f]{6})", s)}
    assert len(p) == 64, f"paleta vga.v: {len(p)} != 64"
    return {k: ((v >> 16) & 255, (v >> 8) & 255, v & 255) for k, v in p.items()}

BARS_F2 = [0x01, 0x16, 0x14, 0x19, 0x3C, 0x28, 0x00, 0x0F]   # = f2_testpat.v
FRAME_F2 = 0x30

def testpat(x, y):
    """f2_testpat.v u NES koordinatama."""
    if x < 4 or 252 <= x < 256 or y < 4 or 236 <= y < 240:
        return FRAME_F2
    return BARS_F2[(x >> 5) & 7]

def expected_f2():
    """Ocekivani 640x480 izlaz vga.v: NES x = (X-65)>>1 za 65 <= X <= 575, NES y = Y>>1."""
    pal = nes_palette()
    img = np.zeros((H, W, 3), np.uint8)
    for Y in range(H):
        for X in range(65, 576):
            img[Y, X] = pal[testpat((X - 65) >> 1, Y >> 1)]
    return img

def regions_f2():
    """(ime, x0, x1, y0, y1, rgb) u VGA koordinatama; granice iz NES geometrije (x2 + 65)."""
    pal = nes_palette()
    vx = lambda nx: 65 + 2 * nx
    r = [("rub_lijevo", 0, 65, 0, H, (0, 0, 0)), ("rub_desno", 576, W, 0, H, (0, 0, 0)),
         ("okvir_gore", vx(32), vx(224), 0, 8, pal[FRAME_F2]), ("okvir_dolje", vx(32), vx(224), 472, 480, pal[FRAME_F2]),
         ("okvir_lijevo", vx(0), vx(4), 16, 464, pal[FRAME_F2]), ("okvir_desno", vx(252), vx(256) - 1, 16, 464, pal[FRAME_F2])]
    for i, c in enumerate(BARS_F2):
        x0, x1 = vx(max(4, 32 * i)), vx(min(252, 32 * i + 32))
        r.append((f"traka{i}_{c:02X}", x0, x1, 8, 472, pal[c]))
    return r

def regions_litex():
    # LiteX VideoColorBars (litex/soc/cores/video.py): 8 traka po 80 px
    cols = [(255, 255, 255), (255, 255, 0), (0, 255, 255), (0, 255, 0),
            (255, 0, 255), (255, 0, 0), (0, 0, 255), (0, 0, 0)]
    return [(f"traka{i}", 80 * i, 80 * i + 80, 0, H, c) for i, c in enumerate(cols)]

def load_ref(path):
    """F4: f4/mkref.py -> 240x256, indeks boje ili -1 (piksel se mijenja, ne provjerava se)."""
    v = [-1 if l == "--" else int(l, 16) for l in Path(path).read_text().split()]
    assert len(v) == 61440, len(v)
    return np.array(v).reshape(240, 256)

def check_f4(img, ref, a, rep):
    """F4: (a) jednolike plocice 8x8 NES piksela (16x16 na VGA) stalnog dijela slike: srednja boja
    najbliza svojoj od boja reference, unutar --tol, std <= --std; crni rubovi kao F2;
    (b) svi stalni pikseli (NES rezolucija, srednja 2x2 VGA): najbliza boja = referenca u >= --min-match."""
    pal = nes_palette()
    cols = sorted({int(c) for c in np.unique(ref) if c >= 0})
    prgb = np.array([pal[c] for c in cols], float)
    rows = []; ok = True
    for name, x0, x1 in (("rub_lijevo", 0, 65), ("rub_desno", 576, W)):
        sub = img[:, x0 + a.inset:x1 - a.inset].reshape(-1, 3); m = sub.mean(0)
        good = bool(np.abs(m).max() <= a.tol and sub.std(0).max() <= a.std); ok &= good
        rows.append({"podrucje": name, "srednja": [round(v, 1) for v in m], "ok": good})
    nb = nbad = 0
    for ty in range(30):
        for tx in range(32):
            t = ref[ty * 8:ty * 8 + 8, tx * 8:tx * 8 + 8]
            if (t < 0).any() or len(np.unique(t)) != 1: continue
            c = int(t[0, 0]); x0, y0 = 65 + 16 * tx, 16 * ty
            sub = img[y0 + a.inset:y0 + 16 - a.inset, x0 + a.inset:x0 + 16 - a.inset].reshape(-1, 3)
            m = sub.mean(0); near = cols[int(np.argmin(((prgb - m) ** 2).sum(1)))]
            good = near == c and np.abs(m - np.array(pal[c])).max() <= a.tol and sub.std(0).max() <= a.std
            nb += 1; nbad += not good
            if not good and nbad <= 10:
                rows.append({"plocica": [tx, ty], "ocekivano": f"{c:02X}", "srednja": [round(v, 1) for v in m],
                             "najbliza": f"{near:02X}", "max_std": round(float(sub.std(0).max()), 1), "ok": False})
    # (b) NES rezolucija: VGA (65 + 2x .. +1, 2y .. +1) -> srednja -> najbliza boja reference
    sm = img[:, 65:65 + 512].reshape(240, 2, 256, 2, 3).mean(axis=(1, 3))
    near = np.array(cols)[np.argmin(((sm[:, :, None, :] - prgb[None, None]) ** 2).sum(-1), axis=-1)]
    st = ref >= 0
    match = float((near[st] == ref[st]).mean())
    rep.update({"plocica_jednolikih": nb, "plocica_krivih": nbad, "stalnih_piksela": int(st.sum()),
                "podudarnost_piksela": round(match, 4), "podrucja": rows})
    print(f"  jednolikih plocica {nb}, krivih {nbad}; stalnih piksela {int(st.sum())}, podudarnost {match:.4f} (prag {a.min_match})")
    for r in rows:
        if not r["ok"]: print(f"  KRIVO {r}")
    return ok and nb > 0 and nbad == 0 and match >= a.min_match

def load(path):
    return np.asarray(Image.open(path).convert("RGB")).astype(int)

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("image")
    ap.add_argument("--spec", choices=["f2", "litex", "f4"], default="f2")
    ap.add_argument("--ref", help="F4: referenca kadra iz f4/mkref.py")
    ap.add_argument("--min-match", type=float, default=0.95, help="F4: min. udio stalnih piksela s tocnom bojom")
    ap.add_argument("--exact", action="store_true", help="tocna usporedba (kadar iz simulacije)")
    ap.add_argument("--tol", type=int, default=64, help="max |srednja - ocekivana| po kanalu (gruba granica)")
    ap.add_argument("--inset", type=int, default=4, help="odmak od granica podrucja (px)")
    ap.add_argument("--std", type=float, default=24.0, help="max std po kanalu unutar podrucja")
    ap.add_argument("--json", help="zapisi izvjestaj")
    a = ap.parse_args()
    img = load(a.image)
    rep = {"slika": a.image, "spec": a.spec, "oblik": list(img.shape)}
    ok = True
    if img.shape != (H, W, 3):
        rep["greska"] = f"oblik {img.shape} != {(H, W, 3)}"; ok = False
    elif img.min() == img.max():
        rep["greska"] = f"jednolika slika (svi pikseli {img.min()}) - NEMA SIGNALA na snimacu"; ok = False
    elif a.spec == "f4":
        ok = check_f4(img, load_ref(a.ref), a, rep)
    elif a.exact:
        exp = expected_f2()
        diff = np.any(img != exp, axis=2)
        rep["krivih_piksela"] = int(diff.sum())
        if diff.any():
            ys, xs = np.nonzero(diff); rep["prvi_krivi"] = [int(xs[0]), int(ys[0]), img[ys[0], xs[0]].tolist(), exp[ys[0], xs[0]].tolist()]
        ok = not diff.any()
    else:
        regs = regions_f2() if a.spec == "f2" else regions_litex()
        palette = sorted({tuple(r[5]) for r in regs})
        rows = []
        for name, x0, x1, y0, y1, rgb in regs:
            # odmak od granica, ali da ostanu bar 2 retka/stupca (okvir je 8 px)
            ix = min(a.inset, (x1 - x0 - 2) // 2); iy = min(a.inset, (y1 - y0 - 2) // 2)
            sub = img[y0 + iy:y1 - iy, x0 + ix:x1 - ix].reshape(-1, 3)
            m, s = sub.mean(0), sub.std(0)
            d = np.abs(m - np.array(rgb))
            # najbliza ocekivana boja (snimac pojacava zasicenje, pa je to glavni kriterij)
            near = min(palette, key=lambda c: float(np.sum((m - np.array(c)) ** 2)))
            good = bool(sub.size > 0 and tuple(near) == tuple(rgb) and d.max() <= a.tol and s.max() <= a.std)
            ok &= good
            rows.append({"podrucje": name, "ocekivano": list(rgb), "srednja": [round(v, 1) for v in m],
                         "najbliza": list(near), "max_odstupanje": round(float(d.max()), 1),
                         "max_std": round(float(s.max()), 1), "piksela": int(sub.shape[0]), "ok": good})
            print(f"  {'OK ' if good else 'KRIVO'} {name:16s} ocek {rgb!s:16s} srednja ({m[0]:5.1f},{m[1]:5.1f},{m[2]:5.1f})"
                  f"  |d|max {d.max():5.1f}  std {s.max():5.1f}  najbliza {near}")
        rep["podrucja"] = rows
    rep["rezultat"] = "PASS" if ok else "FAIL"
    if "greska" in rep: print("  " + rep["greska"])
    if a.exact: print(f"  krivih piksela: {rep.get('krivih_piksela')}  {rep.get('prvi_krivi', '')}")
    if a.json: Path(a.json).write_text(json.dumps(rep, indent=1, ensure_ascii=False))
    print(f"{rep['rezultat']} {a.spec} {a.image}")
    return 0 if ok else 1

if __name__ == "__main__":
    sys.exit(main())
