# Emscripten - Compiling an Existing C Module to WebAssembly

DOCS: https://developer.mozilla.org/en-US/docs/WebAssembly/existing_C_to_wasm

Install
```
brew install emscripten
```

Compile:
```
emcc -O0 -s WASM=1 -s EXPORTED_RUNTIME_METHODS='["cwrap"]' \
     -I libwebp \
     webp.c \
     libwebp/src/{dec,dsp,demux,enc,mux,utils}/*.c \
     -o webp.js
     
wasm2wat webp.wasm -o webp.wat
```

Runtime
```
wasmtime wasm/hello.wasm;  # prints: Hello World
wasmtime js/hello.wasm;    # unknown import: `env::emscripten_memcpy_big` has not been defined
node     js/hello.js       # prints: Hello World
```


Unsolved:
- [index.js](index.js) 
  - unable to load wasm from filesystem without import error
  - unable to call wasm function directly 
  - console.log() vs import stdio.h = 2kb vs 12kb wasm filesize difference
