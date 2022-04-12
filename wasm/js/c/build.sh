#!/bin/bash
# Build Script
# generates: test.c.js test.c.wasm test.c.wat
cd "$(dirname "${BASH_SOURCE[0]}")"  # cd current directory
set -x

emcc     -O ./test.c      -o ./test.c.js # -s EXPORTED_FUNCTIONS=_render
wasm2wat    ./test.c.wasm -o ./test.c.wat
js-beautify ./test.c.js | sponge ./test.c.js