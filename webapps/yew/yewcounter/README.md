# Yew Counter

Inspired by Chapter 5 of Programming WebAssembly with Rust
- https://pragprog.com/titles/khrust/programming-webassembly-with-rust/
- https://www2.irb.hr/korisnici/zskoda/hoffmanWasmRust.pdf

And similar Github implementations
- https://github.com/nukumalik/yew-counter/blob/main/src/main.rs

```
rustup install nightly  
rustup default nightly

cargo install --locked trunk
cargo install wasm-bindgen-cli
cargo install cargo-generate cargo-web

# BUGFIX: thread 'main' panicked at 'unknown name section chunk type: 7' | https://github.com/koute/cargo-web/issues/251
cargo install --git https://github.com/Badel2/cargo-web cargo-web

RUSTFLAGS="-Z macro-backtrace" cargo check 
RUST_BACKTRACE=1 cargo web build --target=wasm32-unknown-unknown 
RUST_BACKTRACE=1 cargo web start --target=wasm32-unknown-unknown
cargo web deploy 
```