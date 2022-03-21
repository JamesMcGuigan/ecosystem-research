#!/bin/bash
cd $(readlink -f $(dirname $BASH_SOURCE[0]));  # cd current directory
set -x

printf "\x00\x61\x73\x6d\x01\x00\x00\x00" > header.wasm
cat header.wasm              # asm
file header.wasm             # header.wasm: WebAssembly (wasm) binary module version 0x1 (MVP)
hexdump  header.wasm         # 0000000   6100 6d73 0001 0000
wasm-objdump -s header.wasm  # header.wasm:    file format wasm 0x1
wasm2wat header.wasm         # (module)
wasmtime header.wasm         # cli execution = null output
echo $?                      # cli exit code