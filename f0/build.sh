#!/usr/bin/env bash
# F0 (TASK-6067): okvir velicine NES-a -- ECP5 referenca i GateMate A1 "kakav je".
#   f0/build.sh ecp5 <ime> [PARAM=VR ...]          # npr. ecp5 bez_dvi C_dvi=0
#   f0/build.sh gm   <ime> [-DGM_FIT4] [PARAM=VR ...]
# Odstupanja od Makefilea: nakon synth_ecp5 ide techmap t:$buf + opt_clean (u varijanti
#   bez DVI-ja ostane 16-bitna '$buf' celija koju nextpnr-ecp5 0.11.1 odbija); router1 jer se
#   router2 rusi (std::out_of_range) na ovom dizajnu.
# Izlaz: ${F0_OUT:-build/f0}/<ime>/ (synth.log, pnr.log, stat.txt, stat_noflat.txt)
# Lanci: ECP5 = oss-cad-suite-20260928 (ghdl plugin; u 20261016/20261018 plugin ima
#        ABI gresku "undefined symbol ...Module6derive"); GM = zadani 20261016,
#        t65 kroz samostalni `ghdl --synth --out=verilog` (plugin ne treba).
set -euo pipefail
cilj=$1; ime=$2; shift 2
ROOT=$(cd "$(dirname "$0")/.." && pwd); cd "$ROOT"
OUT=${F0_OUT:-$ROOT/build/f0}/$ime; mkdir -p "$OUT"
TOOLS=${TOOLS:-$HOME/app/raid/tools}
OSS_ECP5=${OSS_ECP5:-$TOOLS/oss-cad-suite-20260928}
OSS_GM=${OSS_GM:-$TOOLS/oss-cad-suite-20261016}
SEED=${SEED:-1}

VHDL="t65/T65_Pack.vhd t65/T65_MCode.vhd t65/T65_ALU.vhd t65/T65.vhd"
# isti popis kao Makefile (VERILOG_FILES), procitan iz njega
VLOG=$(make -s -f - print <<'MK'
include Makefile
print:
	@echo $(VERILOG_FILES)
MK
)
# Varijanta = promjena ZADANE vrijednosti parametra top.v u kopiji ($OUT/top.v).
# (yosys -chparam ne prima negativne brojeve, a C_usb_speed=-1 je bas takav.)
defs=(); cp top.v "$OUT/top.v"
for a in "$@"; do
  case $a in
    -D*) defs+=("$a");;
    *=*) n=${a%%=*}; v=${a#*=}
         grep -qE "parameter +$n *=" "$OUT/top.v" || { echo "nema parametra $n"; exit 2; }
         sed -i -E "s/(parameter +$n *= *)[^,/ ]+/\1$v/" "$OUT/top.v";;
  esac
done
echo "cilj=$cilj ime=$ime param=[$*]" | tee "$OUT/opis.txt"
diff top.v "$OUT/top.v" >> "$OUT/opis.txt" || true
VLOG=$(echo "$VLOG" | sed "s#\btop.v\b#$OUT/top.v#")

if [ "$cilj" = ecp5 ]; then
  export PATH=$OSS_ECP5/bin:$PATH
  yosys -m ghdl -q -l "$OUT/synth.log" \
    -p "ghdl --std=08 --ieee=synopsys $VHDL -e t65" \
    -p "read_verilog -sv $VLOG" \
    -p "hierarchy -top top" \
    -p "synth_ecp5" -p "techmap -map +/techmap.v t:\$buf" -p "opt_clean" -p "write_json $OUT/nes.json" -p "tee -q -o $OUT/stat.txt stat"
  nextpnr-ecp5 --timing-allow-fail --router router1 --seed "$SEED" --json "$OUT/nes.json" \
    --textcfg "$OUT/nes_out.config" --12k --freq 21 --package CABGA381 \
    --lpf ulx4m_v002.lpf -l "$OUT/pnr.log" >/dev/null 2>&1 || echo "PNR_FAIL rc=$?" | tee -a "$OUT/opis.txt"
elif [ "$cilj" = gm ]; then
  export PATH=$OSS_GM/bin:$PATH
  ghdl --synth --std=08 --ieee=synopsys --out=verilog $VHDL -e t65 > "$OUT/t65_ghdl.v" 2>"$OUT/ghdl.log"
  VLOG_GM=$(echo "$VLOG" | sed 's#\becp5pll.sv\b#f0/gm_stubs.v#')
  yosys -q -l "$OUT/synth.log" \
    -p "read_verilog ${defs[*]:-} -sv $OUT/t65_ghdl.v $VLOG_GM" \
    -p "hierarchy -top top" \
    -p "synth_gatemate -top top -luttree -nomx8" -p "opt_clean" -p "write_json $OUT/nes.json" -p "tee -q -o $OUT/stat.txt stat"
  nextpnr-himbaechel --device CCGM1A1 --json "$OUT/nes.json" --seed "$SEED" \
    -o ccf=f0/gm_clk.ccf -o allow-unconstrained -o fpga_mode=2 -o out="$OUT/nes.txt" \
    --timing-allow-fail -l "$OUT/pnr.log" >/dev/null 2>&1 || echo "PNR_FAIL rc=$?" | tee -a "$OUT/opis.txt"
else
  echo "cilj: ecp5 | gm"; exit 2
fi
echo "gotovo: $OUT"
