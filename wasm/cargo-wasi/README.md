# Cargo WASI

`--target wasm-wasi` compiles .wasm that is linked to the wasi standard library
This reduces executable size, but unlike `--target wasm-unknown-unknown` 
can only be run by wasmtime or compatible environments (ie not web-browsers).


DOCS:
- https://github.com/bytecodealliance/wasmtime/blob/03077e0de9bc5bb92623d58a1e5d78b828fd1634/docs/wasm-rust.md
- https://bytecodealliance.github.io/cargo-wasi/

Install
```
cargo install cargo-wasi
```

Create Project Directory
```
cargo new cargo-wasi
cd cargo-wasi
cargo wasi run
```

Run
- NOTE: `cargo wasi build --release` awaiting bugfix
- USE:  `./target/wasm32-wasi/debug/cargo-wasi.wasm`
```
cargo clean
cargo wasi build
    info: downloading component 'rust-std' for 'wasm32-wasi'
    info: installing component 'rust-std' for 'wasm32-wasi'
     16.7 MiB /  16.7 MiB (100 %)  11.5 MiB/s in  1s ETA:  0s
cargo wasi build
   Compiling cargo-wasi v0.1.0 (/Users/jamie/code/ecosystem-research/wasm/cargo-wasi)
    Finished dev [unoptimized + debuginfo] target(s) in 0.99s
cargo wasi build
    Finished dev [unoptimized + debuginfo] target(s) in 0.00s
cargo wasi build --release   # https://github.com/rustwasm/wasm-pack/issues/913
cargo wasi run
   Compiling cargo-wasi v0.1.0 (/Users/jamie/code/ecosystem-research/wasm/cargo-wasi)
    Finished dev [unoptimized + debuginfo] target(s) in 1.85s
     Running `/Users/jamie/.cargo/bin/cargo-wasi target/wasm32-wasi/debug/cargo-wasi.wasm`
     Running `target/wasm32-wasi/debug/cargo-wasi.wasm`
Hello, world!
```

Relative File Sizes
- `cargo wasi build --release` builds have a 2.5% reduction in 18Mb filesize 
```
find ./ -name '*.wasm' | xargs ls -la
-rwxr-xr-x  1 jamie  staff  1862279 Jun  5 13:46 .//target/wasm32-wasi/debug/cargo-wasi.rustc.wasm*
-rw-r--r--  2 jamie  staff  1855442 Jun  5 13:46 .//target/wasm32-wasi/debug/cargo-wasi.wasi.wasm
-rw-r--r--  2 jamie  staff  1855442 Jun  5 13:46 .//target/wasm32-wasi/debug/cargo-wasi.wasm
-rwxr-xr-x  1 jamie  staff  1862279 Jun  5 13:46 .//target/wasm32-wasi/debug/deps/cargo_wasi-a1bc5c31f10afd38.wasm*
-rwxr-xr-x  1 jamie  staff  1818895 Jun  5 13:38 .//target/wasm32-wasi/release/cargo-wasi.rustc.wasm*
-rwxr-xr-x  1 jamie  staff  1818895 Jun  5 13:38 .//target/wasm32-wasi/release/deps/cargo_wasi-3841e43eadd365f5.wasm*
```

All generated .wasm assets can be invoked
```
find . -name '*.wasm' | xargs -L1 -t wasmtime 
wasmtime ./target/wasm32-wasi/release/deps/cargo_wasi-3841e43eadd365f5.wasm
Hello, world!
wasmtime ./target/wasm32-wasi/release/cargo-wasi.rustc.wasm
Hello, world!
wasmtime ./target/wasm32-wasi/debug/cargo-wasi.wasi.wasm
Hello, world!
wasmtime ./target/wasm32-wasi/debug/cargo-wasi.wasm
Hello, world!
wasmtime ./target/wasm32-wasi/debug/deps/cargo_wasi-a1bc5c31f10afd38.wasm
Hello, world!
wasmtime ./target/wasm32-wasi/debug/cargo-wasi.rustc.wasm
Hello, world!
```



BUG: https://github.com/rustwasm/wasm-pack/issues/913#issuecomment-803563120
```
[12:45:25]jamie@Jamess-MacBook-Pro.local:~/code/ecosystem-research/wasm/cargo-wasi|master$ 
cargo wasi build --release
   Compiling cargo-wasi v0.1.0 (/Users/jamie/code/ecosystem-research/wasm/cargo-wasi)
    Finished release [optimized] target(s) in 0.51s
  Optimizing with wasm-opt
error: failed to process wasm at `/Users/jamie/code/ecosystem-research/wasm/cargo-wasi/target/wasm32-wasi/release/cargo-wasi.rustc.wasm`

Caused by:
    `wasm-opt` failed to execute

Caused by:
    no precompiled binaries of `wasm-opt` are available for this platform, you'll want to set `$WASM_OPT` to a preinstalled `wasm-opt` command or disable via `wasm-opt = false` in your manifest
```
