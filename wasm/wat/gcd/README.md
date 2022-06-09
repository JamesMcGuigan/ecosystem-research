# GCD Greatest Common Denominator in WAT

Source: https://docs.wasmtime.dev/lang-bash.html

Compile
```
wat2wasm gcd.wat 
```

Run
```
wasmtime gcd.wasm --invoke gcd 4 2  # BROKEN
node gcd.js 25 5                    # GCD of 25 and 5 is 5
```


---

## BUG: wasmtime won't run on Xeon E5430 CPUs

wasmtime installed from binaries on my old Xeon E5430 (2007) server reports:
```bash
wasmtime gcd.wat --invoke gcd 34 4
Error: failed to run main module `gcd.wat`

Caused by:
    0: compilation settings are not compatible with the native host
    1: compilation setting "has_sse42" is enabled but not available on the host
```

SSE4 (Streaming SIMD Extensions 4) was also released in 2007, but only available in
Intel Core 2, and i7+ processors.

Bug Report + Fix: https://github.com/bytecodealliance/wasmtime/issues/4224
```
$ git co https://github.com/bytecodealliance/wasmtime.git
$ git fetch --all --tags --prune
$ git co tags/dev 
HEAD is now at 823817595 Fix some typos in the isle language reference (#4248)

$ cargo clean; cargo build --release

$ /usr/local/src/wasmtime/target/release/wasmtime gcd.wasm --invoke gcd 42 24
Error: Unsupported feature: SIMD support requires SSE3, SSSE3, SSE4.1, and SSE4.2 on x86_64.

$ /usr/local/src/wasmtime/target/release/wasmtime --wasm-features=-simd gcd.wasm --invoke gcd 42 24
warning: using `--invoke` with a function that takes arguments is experimental and may break in the future
warning: using `--invoke` with a function that returns values is experimental and may break in the future
6
```