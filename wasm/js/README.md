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