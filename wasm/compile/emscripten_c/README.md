# Compile C via Emscripten

Emscripten is a LLVM to WASM toolchain and compiler.
- https://emscripten.org/

Install
```
# OSX
brew install emscripten

# Arch - https://bugs.archlinux.org/task/52874
pacman -S emscripten
sudo ln -s /usr/lib/emscripten/emcc /usr/local/bin/
sudo ln -s /usr/lib/emscripten/emcc.py /usr/local/bin/
```
