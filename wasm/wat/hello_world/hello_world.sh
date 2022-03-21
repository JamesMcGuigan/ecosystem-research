#!/bin/bash
cd $(readlink -f $(dirname $BASH_SOURCE[0]));  # cd current directory
set -x

## WABT Tools: https://github.com/WebAssembly/wabt
wat-desugar    hello_world.wat      # strip comments + flat format syntax)
wat2wasm       hello_world.wat      # compile binary .wasm
file           hello_world.wasm     # hello_world.wasm: WebAssembly (wasm) binary module version 0x1 (MVP)
hexdump        hello_world.wasm     # 0000000   6100 6d73 0001 0000
wasm-objdump   hello_world.wasm -s  # hello_world.wasm:    file format wasm 0x1
wasm2wat       hello_world.wasm     # (module ... (export "memory" (memory 0)) (export "_start" (func 1)))
wasm-decompile hello_world.wasm     # transpile to C (pseudocode)
wasm2c         hello_world.wasm     # transpile to C (long version)
wasm-validate  hello_world.wasm -v  # BeginExportSection EndExportSection

## Unit Tests
## TODO: generate WASM Spec Test .wast
# wast2json       -v hello_world.wast  # convert wasm spec test format to a JSON + wasm file
# spectest-interp -v hello_world.json  # read a Spectest JSON file, and run its tests in the interpreter


## Compare Runtimes: https://blog.logrocket.com/webassembly-runtimes-compared/
wasm-interp hello_world.wasm --run-all-exports  # error initializing module: invalid import "wasi_unstable.fd_write"
wasmtime    hello_world.wasm                    # execute "hello world"
wasmer      hello_world.wasm                    # execute "hello world"
# lucet = https://github.com/bytecodealliance/lucet
# WebAssembly Micro Runtime (WAMR) = https://github.com/bytecodealliance/wasm-micro-runtime
