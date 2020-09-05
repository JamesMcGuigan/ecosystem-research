# Rust Crash Course
- Youtube Video: https://www.youtube.com/watch?v=zF34dRivLOw
- Rust Book: https://doc.rust-lang.org/1.30.0/book/2018-edition/index.html

## Update Rust
```
rustup --version
rustup update
rustc --version
```

## Compile Rust
### Without Cargo
```
rustc -O hello.rs   # ls -lh ./hello = 2.8M
time ./hello        # time user = 0m0.003s    
> Hello World!
```

### With Cargo
```
cargo init     # creates Cargo.toml + src/main.rs
cargo run
cargo run -q   # Quiet mode
./target/debug/rust-crash-course    # 2.8MB

cargo build --release 
./target/release/rust-crash-course  # 2.8MB
```


## Why is the binary so large
- https://lifthrasiir.github.io/rustlog/why-is-a-rust-executable-large.html
- https://rust-embedded.github.io/book/unsorted/speed-vs-size.html#optimize-for-speed

NOTE: Now that IS smaller! About a half of the entire executable was for debugging symbols. Note that, having stripped our symbols, we cannot have a nice backtrace nor panic recovery:
      
Running strip removes debugging symbols, and human-readable backtrace/panic error messages 
```
strings ./hello | wc -c  # 927632  | ls -lh ./hello = 2.8M
strip   ./hello
strings ./hello | wc -c  # 19189   | ls -lh ./hello = 231K
```

### Show backtraces
```
rustc -O ./panic.rs
RUST_BACKTRACE=1 ./panic
```