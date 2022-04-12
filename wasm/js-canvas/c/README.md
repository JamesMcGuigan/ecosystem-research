# Javascript WASM
DOCS
- https://compile.fi/canvas-filled-three-ways-js-webassembly-and-webgl/
- https://developer.mozilla.org/en-US/docs/WebAssembly/Loading_and_running


## Install EMSDK
```
cd git clone https://github.com/emscripten-core/emsdk.git
cd emsdk
./emsdk install latest
./emsdk activate latest
echo 'source "/usr/local/src/emsdk/emsdk_env.sh"' >> $HOME/.bash_profile
emsdk --help
```

## Install wasm2wat
```
sudo pacman -S wabt       # wasm2wat
sudo pacman -S moreutils  # sponge
sudo npm install -g js-beautify
```

## Compile
```
# ./build.sh generates: test.c.js test.c.wasm test.c.wat
emcc     -O ./test.c      -o ./test.c.js  # -s EXPORTED_FUNCTIONS=_render
wasm2wat    ./test.c.wasm -o ./test.c.wat
js-beautify ./test.c.js | sponge ./test.c.js
```

# NOTES

## EMSCRIPTEN_KEEPALIVE
- This prevents -O3 from pruning export functions
- `#define EMSCRIPTEN_KEEPALIVE attribute((used))`
- https://github.com/emscripten-core/emscripten/issues/6546

## .wat

Different array preallocation sizes are visable in the .wat file 
```
test.c:     int canvas_buffer[1920 * 1080];  
test.c.wat: (func (;9;) (type 0) (result i32) i32.const 8295424) 
            (global (;0;) (mut i32) (i32.const 13538320))

test.c:     int canvas_buffer[256];
test.c.wat: (func (;9;) (type 0) (result i32) i32.const 2048)    
            (global (;0;) (mut i32) (i32.const 5244944))
```

Canvas rendering still seems to work even if insufficent memory is preallocated.
Unsure about the implications of buffer overflow inside a WASM file 