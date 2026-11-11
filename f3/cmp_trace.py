#!/usr/bin/env python3
"""F3 (TASK-6070): usporedba traga f3_cpu_sys s nestest.log (PC, A, X, Y, P, SP po instrukciji;
CYC relativno prema prvom retku). Ispise broj podudarnih redaka, prvi razilaz i CRC-32 traga
(isti CRC racuna plocica: bajtovi PCH PCL A X Y P&maska S po instrukciji, zlib.crc32).
   f3/cmp_trace.py nestest.log trace.txt [--p-mask 0xCF]"""
import re, sys, zlib
ref_path, tr_path = sys.argv[1], sys.argv[2]
pmask = int(sys.argv[sys.argv.index('--p-mask') + 1], 0) if '--p-mask' in sys.argv else 0xFF
R = re.compile(r'^([0-9A-F]{4}) .*A:([0-9A-F]{2}) X:([0-9A-F]{2}) Y:([0-9A-F]{2}) P:([0-9A-F]{2}) SP:([0-9A-F]{2}).*CYC:(\d+)')
ref = []
for ln in open(ref_path):
    m = R.match(ln)
    if m: ref.append(tuple(int(v, 16) for v in m.groups()[:6]) + (int(m.group(7)),))
tr = [tuple(int(v, 16) for v in l.split()[:6]) + (int(l.split()[6]),) for l in open(tr_path) if l.strip()]
names = ('PC', 'A', 'X', 'Y', 'P', 'SP', 'CYC')
off = ref[0][6] - tr[0][6] if tr else 0
ok, first, nbad, last_bad = 0, None, 0, None
for i, (r, t) in enumerate(zip(ref, tr)):
    diff = [k for k in range(6) if (r[k] & (pmask if k == 4 else 0xFFFF)) != (t[k] & (pmask if k == 4 else 0xFFFF))]
    cyc_bad = (t[6] + off) != r[6]
    if diff or cyc_bad:
        nbad += 1; last_bad = i
        if first is None: first = (i, r, t, diff, cyc_bad)
    elif first is None:
        ok += 1
def crc(rows):   # P s maskom (kao plocica: bit B izvan CRC-a) -> CRC traga = CRC reference ako je trag isti
    b = bytearray()
    for r in rows: b += bytes([r[0] >> 8, r[0] & 255, r[1], r[2], r[3], r[4] & pmask, r[5]])
    return zlib.crc32(b)
print(f'referenca: {len(ref)} redaka, trag: {len(tr)} redaka, pomak CYC {off}, maska P 0x{pmask:02X}')
print(f'PODUDARNO: {ok}/{len(ref)} redaka do prvog razilaza; ukupno razlicitih {nbad}' + (f', zadnji redak {last_bad+1}' if nbad else ''))
if first:
    i, r, t, diff, cb = first
    f = lambda x: f'{x[0]:04X} A:{x[1]:02X} X:{x[2]:02X} Y:{x[3]:02X} P:{x[4]:02X} SP:{x[5]:02X} CYC:{x[6]}'
    print(f'PRVI RAZILAZ redak {i+1}: polja {[names[k] for k in diff] + (["CYC"] if cb else [])}')
    print(f'  ref : {f(r)}\n  trag: {f((t[0],t[1],t[2],t[3],t[4],t[5],t[6]+off))}')
elif len(tr) < len(ref):
    print(f'trag kraci od reference ({len(tr)} < {len(ref)})')
else:
    print('TRAG = REFERENCA')
print(f'CRC32 traga ({len(tr)} redaka): {crc(tr):08X}; reference: {crc(ref):08X}')
