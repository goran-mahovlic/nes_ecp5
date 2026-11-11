#!/usr/bin/env python3
"""F0 (TASK-6067): tablica resursa iz build/f0/<ime>/pnr.log (+ stat.txt).

Upotreba: f0/izvuci.py <mapa_f0> [ime ...]
"""
import re, sys, os

ECP5 = ["TRELLIS_COMB", "TRELLIS_FF", "TRELLIS_RAMW", "DP16KD", "MULT18X18D", "EHXPLLL", "DCCA", "TRELLIS_IO"]
GM = ["CPE", "CPE_LT", "CPE_FF", "RAM", "RAM_HALF", "PLL", "GLBOUT", "BUFG", "IOSEL", "MULT"]

def util(log):
    u = {}
    for m in re.finditer(r"Info:\s+(\S+):\s+(\d+)/\s*(\d+)\s+(\d+)%", log):
        u[m.group(1)] = (int(m.group(2)), int(m.group(3)))
    return u

def fmax(log):
    f = {}
    for m in re.finditer(r"Max frequency for clock\s+'([^']+)':\s+([\d.]+) MHz \((PASS|FAIL) at ([\d.]+) MHz\)", log):
        f[m.group(1)] = (float(m.group(2)), m.group(3), float(m.group(4)))  # zadnja pojava = nakon routanja
    return f

def main():
    root = sys.argv[1]
    imena = sys.argv[2:] or sorted(os.listdir(root))
    for ime in imena:
        p = os.path.join(root, ime, "pnr.log")
        if not os.path.exists(p): continue
        log = open(p, errors="replace").read()
        u = util(log); f = fmax(log)
        err = re.findall(r"^ERROR: (.*)$", log, re.M)
        print(f"## {ime}")
        if err: print(f"- **P&R nije prosao:** `{err[-1]}`")
        if "Routing complete" in log or "Program finished normally" in log: print("- P&R: rutanje dovrseno")
        for k, (a, b) in u.items():
            if a: print(f"- {k}: {a}/{b} ({100*a/b:.1f} %)")
        for k, (mhz, st, req) in f.items():
            print(f"- Fmax {k}: {mhz:.2f} MHz ({st} @ {req:.2f})")
        print()

if __name__ == "__main__":
    main()
