# Javascript WASM via Rust
DOCS
- https://developer.mozilla.org/en-US/docs/WebAssembly/Rust_to_wasm
- https://doc.rust-lang.org/cargo/guide/creating-a-new-project.html
- https://rustwasm.github.io/docs/wasm-bindgen/
- https://rustwasm.github.io/wasm-bindgen/reference/cli.html
- https://stackoverflow.com/questions/64308461/failed-to-load-wasm-application
- https://rustwasm.github.io/docs/wasm-bindgen/reference/deployment.html#bundlers

## Install Rust

Prefer installing via rustup rather than Arch pacman 
```
curl https://sh.rustup.rs -sSf | sh  # Install Rust
source $HOME/.cargo/env   # .bashrc

cargo install wasm-pack
sudo pacman -S emscripten
cargo install -f wasm-bindgen-cli  
```


Inspect Compile Targets
```
rustc --print target-list | grep wasm 
    wasm32-unknown-emscripten
    wasm32-unknown-unknown
    wasm32-wasi
    wasm64-unknown-unknown   # fails to install
    
rustc --print target-list | grep wasm | xargs -t -L1 rustup target add    
```
- Compare: https://users.rust-lang.org/t/wasm-unknown-vs-emscripten/22997/5

## Create New Project
```
cargo new canvas-wasm --lib --vcs none
```

## Compile
NOTE: `--target wasm32-unknown-unknown` defined in `.cargo/config`
```  
cargo clean

cargo build --target wasm32-unknown-unknown
    ./target/wasm32-unknown-unknown/debug/deps/canvas_wasm.wasm
    ./target/wasm32-unknown-unknown/debug/canvas_wasm.wasm

cargo build --release --target wasm32-unknown-unknown  
    ./target/wasm32-unknown-unknown/release/deps/canvas_wasm.wasm
    ./target/wasm32-unknown-unknown/release/canvas_wasm.wasm

# FIX: wasm32-unknown-emscripten | https://github.com/rust-lang/rust/issues/85821
EMCC_CFLAGS="-s ERROR_ON_UNDEFINED_SYMBOLS=0"  cargo build --release --target wasm32-unknown-emscripten
    ./target/wasm32-unknown-emscripten/release/deps/canvas_wasm.wasm
    ./target/wasm32-unknown-emscripten/release/canvas_wasm.wasm 
```

This runs wasm-bindgen, but unsure if this is usable 
```  
wasm-bindgen ./target/wasm32-unknown-unknown/debug/canvas_wasm.wasm   --out-dir ./target/wasm32-unknown-unknown/debug/wasm-bindgen/
wasm-bindgen ./target/wasm32-unknown-unknown/release/canvas_wasm.wasm --out-dir ./target/wasm32-unknown-unknown/release/wasm-bindgen/
``` 

DOCS: https://stackoverflow.com/questions/64308461/failed-to-load-wasm-application
```
wasm-pack build --release --target web
```
