# Yew Counter

Inspired by Chapter 5 of Programming WebAssembly with Rust
- https://pragprog.com/titles/khrust/programming-webassembly-with-rust/
- https://www2.irb.hr/korisnici/zskoda/hoffmanWasmRust.pdf

And similar Github implementations
- https://github.com/nukumalik/yew-counter/blob/main/src/main.rs

```
rustup install nightly  
rustup default nightly
RUSTFLAGS="-Z macro-backtrace" cargo check 
cargo build --target=wasm32-unknown-unknown 
cargo web start --target=wasm32-unknown-unknown 
```