# Compile C to WASM

DOCS: https://developer.mozilla.org/en-US/docs/WebAssembly/C_to_wasm

Install
```
brew install emscripten
```

Compile to different targets
```
emcc hello.c -o wasm/hello.wasm;
emcc hello.c -o js/hello.js
emcc hello.c -o html/hello.html 

find ./ -name '*.wasm' -exec wasm2wat {} -o {}.wat \;
```

Runtime
```
wasmtime wasm/hello.wasm;  # prints: Hello World
wasmtime js/hello.wasm;    # unknown import: `env::emscripten_memcpy_big` has not been defined
node     js/hello.js       # prints: Hello World
```
