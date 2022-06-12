# Yew Counter

Inspired by Chapter 5 of Programming WebAssembly with Rust
- https://pragprog.com/titles/khrust/programming-webassembly-with-rust/
- https://www2.irb.hr/korisnici/zskoda/hoffmanWasmRust.pdf

And similar Github implementations
- https://github.com/nukumalik/yew-counter/blob/main/src/main.rs

Install
```bash
rustup install nightly  
rustup default nightly

cargo install --locked trunk
cargo install wasm-bindgen-cli
cargo install cargo-expand
cargo install cargo-generate cargo-web

# BUGFIX: thread 'main' panicked at 'unknown name section chunk type: 7' | https://github.com/koute/cargo-web/issues/251
cargo install --git https://github.com/Badel2/cargo-web cargo-web
cargo install --path .
```

Validate
```bash
RUSTFLAGS="-Z macro-backtrace" cargo check
cargo expand --lib | cat 
cargo expand --bin yewcounter | cat 
```

Build
```bash
## Use Trunk - https://yew.rs/docs/getting-started/project-setup/using-trunk
trunk clean
trunk serve --open  # Works - requires index.html
trunk build --release
http-server dist/               # Javascript webserver
see start -b 8080 -p dist/      # Rust webserver


## BROKEN: cargo build with Yew 
# RUST_BACKTRACE=1 cargo web build --target=wasm32-unknown-unknown 
# RUST_BACKTRACE=1 cargo web start --target=wasm32-unknown-unknown
# cargo web deploy  # generate ./target/deploy/

## BROKEN: wasm-pack with Yew
## - DOCS: https://yew.rs/docs/getting-started/project-setup/using-wasm-pack
## - WORKING EXAMPLE: https://github.com/yewstack/yew-wasm-pack-minimal
## - WORKING EXAMPLE: https://github.com/yewstack/yew-wasm-pack-template
# npm install --global rollup   
# wasm-pack build --target web
# rollup ./main.js --format iife --file ./pkg/bundle.js
```
