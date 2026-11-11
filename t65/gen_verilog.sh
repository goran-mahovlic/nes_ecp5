#!/usr/bin/env bash
# F3 (TASK-6070), plan "Do bitstreama za GS" #4: t65 (VHDL) -> Verilog jednom, samostalnim
# `ghdl --synth --out=verilog` (yosys ghdl.so plugin u oss-cad-suite-20261016 ne radi, ABI).
# Izlaz se commita: t65/t65_ghdl.v -> GateMate tok cisti yosys/iverilog, bez ghdl-a.
#   t65/gen_verilog.sh            (OSS_GM=<mapa> za drugi lanac)
set -euo pipefail
ROOT=$(cd "$(dirname "$0")/.." && pwd); cd "$ROOT"
OSS=${OSS_GM:-$HOME/app/raid/tools/oss-cad-suite-20261016}
export PATH=$OSS/bin:$PATH
WORK=$(mktemp -d "${TMPDIR:-$ROOT/build}/t65ghdl.XXXX")
VHDL="t65/T65_Pack.vhd t65/T65_MCode.vhd t65/T65_ALU.vhd t65/T65.vhd"
OUT=t65/t65_ghdl.v
{
  echo "// GENERIRANO: t65/gen_verilog.sh ($(ghdl --version | head -1 | cut -c1-60))"
  echo "// izvor: $VHDL ; NE UREDJIVATI RUCNO"
  ghdl --synth --std=08 --ieee=synopsys --workdir="$WORK" --out=verilog $VHDL -e t65
} | sed -E 's/\bbreak\b/break_i/g' > "$OUT.tmp"   # `break` je kljucna rijec SV-a (iverilog -g2012, yosys -sv)
mv "$OUT.tmp" "$OUT"
rm -r "$WORK"
echo "$OUT: $(wc -l < "$OUT") redaka, sha256 $(sha256sum "$OUT" | cut -c1-16)"
