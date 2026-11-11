#!/usr/bin/env python3
"""F3 vrata 2 (TASK-6070): provjera UART zapisa s plocice prema simulaciji.
Uzima samo retke svjezeg ucitavanja (od zadnjeg T=0001; ono prije je stari medjuspremnik ttyACM-a).
  - svaki redak: N=231F, PC=0001, R=0000 (nestest PASS), E=1, C = C iz simulacije (0067BF)
  - T=0001: pokrene sim/f3/tb_f3_cpu.v s pocetnim A/X/Y iz polja I= i trazi isti H (CRC 8991 zapisa)
  - T>=2:   H = H_T2 iz sim/f3/tb_f3_top.v (drugi prolaz krece od ostatka prvog: A=00 X=FF Y=15)
   f3/check_uart.py lab_*.log ..."""
import os, re, subprocess, sys, zlib
ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
OSS = os.environ.get('OSS_GM', os.path.expanduser('~/app/raid/tools/oss-cad-suite-20261016'))
H_T2, C_REF = '4769AB60', '0067BF'
R = re.compile(r'F3 T=(\w{4}) N=(\w{4}) C=(\w{6}) PC=(\w{4}) A=\w\w X=\w\w Y=\w\w P=\w\w S=\w\w R=(\w{4}) H=(\w{8}) E=(\w) I=(\w{10})')
OUT = os.path.join(ROOT, 'build/f3/sim'); os.makedirs(OUT, exist_ok=True)
cache = {}
def sim_h(axy):
    if axy in cache: return cache[axy]
    tr, vvp = f'{OUT}/trace_i{axy}.txt', f'{OUT}/tb_i{axy}.vvp'
    env = dict(os.environ, PATH=f'{OSS}/bin:' + os.environ['PATH'])
    subprocess.run(['iverilog', '-g2012', '-o', vvp, f"-Ptb_f3_cpu.INIT_AXY=24'h{axy}", f'-Ptb_f3_cpu.TRACE="{tr}"',
                    't65/t65_ghdl.v', 'f3/f3_cpu_sys.v', 'sim/f3/tb_f3_cpu.v'], cwd=ROOT, env=env, check=True)
    subprocess.run(['vvp', '-n', vvp], cwd=ROOT, env=env, check=True, capture_output=True)
    b = bytearray()
    for l in open(tr):
        v = [int(x, 16) for x in l.split()[:6]]
        b += bytes([v[0] >> 8, v[0] & 255, v[1], v[2], v[3], v[4] & 0xEF, v[5]])
    cache[axy] = f'{zlib.crc32(b):08X}'
    return cache[axy]
ok = bad = 0
for path in sys.argv[1:]:
    lines = [m for m in (R.search(l) for l in open(path, errors='replace')) if m]
    starts = [i for i, m in enumerate(lines) if m.group(1) == '0001']
    fresh = lines[starts[-1]:] if starts else []
    print(f'{os.path.basename(path)}: {len(fresh)} svjezih redaka')
    for m in fresh:
        T, N, C, PC, Rr, H, E, I = m.groups()
        exp = sim_h(I[:6]) if T == '0001' else H_T2
        good = N == '231F' and PC == '0001' and Rr == '0000' and E == '1' and C == C_REF and H == exp
        ok += good; bad += not good
        if T == '0001' or not good:
            print(f'  T={T} I={I} H={H} sim={exp} R={Rr} -> {"OK" if good else "RAZLIKA"}')
print(f'UKUPNO: {ok} OK, {bad} razlika')
sys.exit(1 if bad or not ok else 0)
