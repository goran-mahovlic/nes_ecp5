#!/usr/bin/env python3
"""F3 (TASK-6070): iNES (.nes) -> PRG ROM kao $readmemh (jedan bajt po retku).
   f3/mkhex.py igra.nes izlaz.hex   -- samo mapper 0 (NROM), 16 ili 32 KB PRG."""
import sys
d = open(sys.argv[1], 'rb').read()
assert d[:4] == b'NES\x1a', 'nije iNES'
prg_kb, mapper = d[4] * 16, (d[6] >> 4) | (d[7] & 0xF0)
assert mapper == 0, f'mapper {mapper} nije NROM'
assert prg_kb in (16, 32), prg_kb
off = 16 + (512 if d[6] & 4 else 0)
prg = d[off:off + prg_kb * 1024]
open(sys.argv[2], 'w').write(''.join(f'{b:02x}\n' for b in prg))
print(f'{sys.argv[2]}: PRG {prg_kb} KB, CHR {d[5]*8} KB, mapper 0, reset ${prg[-4]|prg[-3]<<8:04X}')
