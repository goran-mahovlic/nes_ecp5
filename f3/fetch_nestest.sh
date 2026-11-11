#!/usr/bin/env bash
# nestest.log (kevtris, referentni trag Nintendulatora) -- ne commita se (859 KB); sha256 provjeren.
set -euo pipefail
OUT=${1:-build/f3/nestest.log}; mkdir -p "$(dirname "$OUT")"
curl -sSfL -o "$OUT" https://raw.githubusercontent.com/christopherpow/nes-test-roms/master/other/nestest.log
echo "442c4dd5539c7e88b3fd73c7b732a7eadbd22b47c2cd9e58397ef147f64f6f8f  $OUT" | sha256sum -c
