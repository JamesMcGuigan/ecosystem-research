#!/usr/bin/env bash
cd $(readlink -f $(dirname $BASH_SOURCE[0]));  # cd current directory
set -x

git clone https://github.com/webmproject/libwebp
emcc -O0 -s WASM=1 -s EXPORTED_RUNTIME_METHODS='["cwrap"]' \
     -I libwebp \
     webp.c \
     libwebp/src/{dec,dsp,demux,enc,mux,utils}/*.c \
     -o webp.js

wasm2wat webp.wasm -o webp.wat
wasmtime wasm/hello.wasm;  # prints: Hello World
wasmtime js/hello.wasm;    # unknown import: `env::emscripten_memcpy_big` has not been defined
node     js/hello.js       # prints: Hello World
