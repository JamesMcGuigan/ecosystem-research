# Compile Rust to WASM

DOCS: https://rustwasm.github.io/docs/book/game-of-life/hello-world.html

Install Rust
```
curl https://sh.rustup.rs -sSf | sh 
cargo install cargo-generate         # https://github.com/cargo-generate/cargo-generate
cargo install wasm-pack
```
- https://doc.rust-lang.org/cargo/getting-started/installation.html

NOTE: Use rustup over pacman on Arch Linux
- https://rustwasm.github.io/wasm-pack/book/prerequisites/non-rustup-setups.html
- https://www.reddit.com/r/rust/comments/6gfebh/use_rustup_or_distros_package_manager/
- `sudo pacman -R rust`

WASM Template Projects
```
wasm-pack new hello-wasm
cargo generate --git https://github.com/rustwasm/wasm-pack-template  --name wasm-game-of-life

wasm-pack build
find ./ -name '*.wasm' -exec wasm2wat {} -o {}.wat \; -print
```