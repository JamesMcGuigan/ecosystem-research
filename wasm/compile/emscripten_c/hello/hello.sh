#!/usr/bin/env bash
cd $(readlink -f $(dirname $BASH_SOURCE[0]));  # cd current directory
set -x

emcc hello.c -o wasm/hello.wasm;
emcc hello.c -o js/hello.js
emcc hello.c -o html/hello.html
find ./ -name '*.wasm' -exec wasm2wat {} -o {}.wat \;
wasmtime wasm/hello.wasm;  # prints: Hello World
wasmtime js/hello.wasm;    # unknown import: `env::emscripten_memcpy_big` has not been defined
node     js/hello.js       # prints: Hello World
