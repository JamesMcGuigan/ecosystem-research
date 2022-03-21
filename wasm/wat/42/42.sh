#!/bin/bash
cd $(readlink -f $(dirname $BASH_SOURCE[0]));  # cd current directory
set -x

wat2wasm    42.wat -o 42.wasm          # compile
wasmtime    42.wasm                    # no output
wasm-interp 42.wasm                    # no output
wasm-interp --run-all-exports 42.wasm  # main() => i32:42
