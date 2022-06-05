#!/bin/bash
cd $(dirname $BASH_SOURCE[0]);  # cd current directory
set -x

wat2wasm checkers.wat
wasm2wat checkers.wasm -o checkers.wasm.wat
wasm2c   checkers.wasm -o checkers.wasm.c
wasm-objdump checkers.wasm -hdxrs | tee checkers.wasm.objdump

## WABT Tools: https://github.com/WebAssembly/wabt
wat-desugar    checkers.wat      # strip comments + flat format syntax)
file           checkers.wasm     # checkers.wasm: WebAssembly (wasm) binary module version 0x1 (MVP)
hexdump        checkers.wasm     # 0000000   6100 6d73 0001 0000
wasm-decompile checkers.wasm     # transpile to C (pseudocode)
wasm-validate  checkers.wasm -v  # BeginExportSection EndExportSection

ls -l *.wat *.wasm* | sort -nr -k5

#./test.sh
#./test.bats