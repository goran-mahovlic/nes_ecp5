#!/usr/bin/env python3
"""F0 (TASK-6067): zbroji primitive po podstablu iz yosys `stat` ispisa (sinteza -noflatten).

Upotreba: stat_tree.py stat.txt [--top top] [--grupe]
Ispisuje za svaki modul (s podmodulima) zbroj odabranih primitiva.
"""
import re, sys, argparse
from collections import defaultdict

ECP5 = {"LUT4": "LUT4", "CCU2C": "CCU2C", "TRELLIS_FF": "FF", "DP16KD": "DP16KD",
        "MULT18X18D": "MULT18", "TRELLIS_DPR16X4": "DPR16X4", "PFUMX": "PFUMX", "L6MUX21": "L6MUX"}
# GateMate: CC_LUT*/CC_L2T*/CC_MX* = CPE logika, CC_DFF/CC_DLT = FF, CC_ADDF = zbrajalo
def kind(cell):
    if cell in ECP5: return ECP5[cell]
    if cell.startswith("CC_BRAM_20K"): return "RAM_HALF"
    if cell.startswith("CC_BRAM_40K"): return "RAM_FULL"
    if cell in ("CC_DFF", "CC_DLT"): return "FF"
    if cell.startswith("CC_LUT") or cell.startswith("CC_L2T") or cell.startswith("CC_MX"): return "LT"
    if cell == "CC_ADDF": return "ADDF"
    if cell == "CC_MULT": return "MULT"
    return None

def parse(path):
    mods, cur, in_sub = {}, None, False
    for line in open(path):
        m = re.match(r"^=== (.*) ===", line)
        if m:
            cur = m.group(1)
            if cur == "design hierarchy": cur = None; continue
            mods[cur] = {"cells": defaultdict(int), "subs": defaultdict(int)}; in_sub = False
            continue
        if cur is None: continue
        m = re.match(r"^\s+(\d+) submodules", line)
        if m: in_sub = True; continue
        m = re.match(r"^\s+(\d+) cells", line)
        if m: in_sub = False; continue
        m = re.match(r"^\s+(\d+)\s{3}(\S+)\s*$", line)
        if m:
            (mods[cur]["subs"] if in_sub else mods[cur]["cells"])[m.group(2)] += int(m.group(1))
    return mods

def short(n):
    n = re.sub(r"^\$paramod\$[0-9a-f]+\\", "", n)
    n = re.sub(r"^\$paramod\\([^\\]+)\\.*$", r"\1", n)
    return n

def total(mods, name, memo):
    if name in memo: return memo[name]
    t = defaultdict(int)
    for c, k in mods[name]["cells"].items():
        kk = kind(c)
        if kk: t[kk] += k
    for s, k in mods[name]["subs"].items():
        if s in mods:
            for kk, v in total(mods, s, memo).items(): t[kk] += v * k
    memo[name] = t
    return t

def main():
    ap = argparse.ArgumentParser(); ap.add_argument("stat"); ap.add_argument("--top", default="top")
    ap.add_argument("--dubina", type=int, default=2)
    a = ap.parse_args()
    mods = parse(a.stat); memo = {}
    cols = sorted({k for m in mods for c in mods[m]["cells"] for k in [kind(c)] if k})
    print("| modul | " + " | ".join(cols) + " |"); print("|---" * (len(cols) + 1) + "|")
    def walk(name, d, mult):
        t = total(mods, name, memo)
        print(f"| {'· ' * d}{short(name)}{' ×%d' % mult if mult > 1 else ''} | " + " | ".join(str(t.get(c, 0) * mult) for c in cols) + " |")
        if d < a.dubina:
            subs = sorted(mods[name]["subs"].items(), key=lambda kv: -sum(total(mods, kv[0], memo).values()) if kv[0] in mods else 0)
            for s, k in subs:
                if s in mods: walk(s, d + 1, k)
    walk(a.top, 0, 1)

if __name__ == "__main__":
    main()
