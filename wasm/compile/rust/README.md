# Compile Rust to WASM

DOCS: https://rustwasm.github.io/docs/book/game-of-life/hello-world.html

Install Rust
```
pacman -S rust                       # Arch Linux 
curl https://sh.rustup.rs -sSf | sh  # OSX
cargo install cargo-generate         # https://github.com/cargo-generate/cargo-generate
cargo install wasm-pack
```
- https://doc.rust-lang.org/cargo/getting-started/installation.html

WASM Template Projects
```
wasm-pack new hello-wasm.
cargo generate --git https://github.com/rustwasm/wasm-pack-template  --name wasm-game-of-life

wasm-pack build
find ./ -name '*.wasm' -exec wasm2wat {} -o {}.wat \; -print
```