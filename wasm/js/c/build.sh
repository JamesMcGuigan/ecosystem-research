#!/bin/bash
# Build Script
# generates: test.c.js test.c.wasm test.c.wat
cd "$(dirname "${BASH_SOURCE[0]}")"  # cd current directory
set -x

emcc     -O ./src/test.c      -o ./src/test.c.js  # -s EXPORTED_FUNCTIONS=_render
wasm2wat    ./src/test.c.wasm -o ./src/test.c.wat
js-beautify ./src/test.c.js | sponge ./src/test.c.js