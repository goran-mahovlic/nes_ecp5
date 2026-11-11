#!/usr/bin/env python3
"""F3/F4: iNES (.nes) -> PRG (i CHR) ROM kao $readmemh (jedan bajt po retku), samo mapper 0 (NROM).
   f3/mkhex.py igra.nes prg.hex [chr.hex]
F4 (TASK-6071): treci argument zapisuje CHR ROM (8 KB; CHR RAM = 8 KB nula) i ispisuje
mapper_flags u obliku game_loader.v: {CHR RAM, zrcaljenje, chr_size, prg_size, mapper}."""
import sys
d = open(sys.argv[1], 'rb').read()
assert d[:4] == b'NES\x1a', 'nije iNES'
prg_kb, chr_kb, mapper = d[4] * 16, d[5] * 8, (d[6] >> 4) | (d[7] & 0xF0)
assert mapper == 0, f'mapper {mapper} nije NROM'
assert prg_kb in (16, 32), prg_kb
assert chr_kb in (0, 8), chr_kb
off = 16 + (512 if d[6] & 4 else 0)
prg = d[off:off + prg_kb * 1024]
open(sys.argv[2], 'w').write(''.join(f'{b:02x}\n' for b in prg))
msg = f'{sys.argv[2]}: PRG {prg_kb} KB, CHR {chr_kb} KB, mapper 0, reset ${prg[-4]|prg[-3]<<8:04X}'
if len(sys.argv) > 3:
    chr_ = d[off + prg_kb * 1024:off + prg_kb * 1024 + chr_kb * 1024] if chr_kb else bytes(8192)
    assert len(chr_) == 8192, len(chr_)
    open(sys.argv[3], 'w').write(''.join(f'{b:02x}\n' for b in chr_))
    size = lambda n: next(i for i, m in enumerate((1, 2, 4, 8, 16, 32, 64)) if n <= m) if n <= 64 else 7
    flags = (int(chr_kb == 0) << 15) | ((d[6] & 1) << 14) | (size(d[5]) << 11) | (size(d[4]) << 8) | mapper
    msg += f'; {sys.argv[3]}: CHR {"RAM" if chr_kb == 0 else "ROM"}, zrcaljenje {"V" if d[6] & 1 else "H"}, mapper_flags 32\'h{flags:08X}'
print(msg)
