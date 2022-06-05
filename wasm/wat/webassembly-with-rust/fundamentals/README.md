# Programming WebAssembly with Rust - Fundamentals

```
wat2wasm add1.wat -o add1.wasm
wat2wasm add2.wat 

# warning: using `--invoke` with a function that returns values is experimental and may break in the future
wasmtime add1.wat  --invoke add 42 34  2> /dev/null
wasmtime add1.wasm --invoke add 42 34  2> /dev/null
wasmtime add2.wat  --invoke add 42 34  2> /dev/null
wasmtime add2.wasm --invoke add 42 34  2> /dev/null
```