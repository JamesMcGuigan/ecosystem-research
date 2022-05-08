# Rust -> WASM pointers
- DOCS: https://wasmbyexample.dev/examples/webassembly-linear-memory/webassembly-linear-memory.rust.en-us.html

The C implementation [/wasm/js-canvas/c/](../../wasm/js-canvas/c/) 
defined a hardcoded array in C memory, then passed a pointer back to javascript.

This is considered an unsafe operation in Rust, but the same method is still possible

### Javascript
```javascript
WebAssembly.instantiateStreaming(fetch(wasm_file), {})
.then(wasm_module => { console.warn(wasm_file); return wasm_module.instance.exports; })
.then(wasm => {
    // Define WASM memory in Rust and return a pointer to Javascript
    wasm.store_value_in_wasm_memory_buffer_index_zero(42);
    let memory  = new Uint8Array(wasm.memory.buffer);    // Rust allocates 1114112 bytes = ~1.114Mb by default
    let pointer = wasm.get_wasm_memory_buffer_pointer(); // 1048584 | 1050664
    console.log(`rust memory[${pointer}] =`, memory[pointer], memory);
})
```

### Rust
```rust
use wasm_bindgen::prelude::*;
const WASM_MEMORY_BUFFER_SIZE: usize = 2;
static mut WASM_MEMORY_BUFFER: [u8; WASM_MEMORY_BUFFER_SIZE] = [0; WASM_MEMORY_BUFFER_SIZE];

#[wasm_bindgen]
pub fn store_value_in_wasm_memory_buffer_index_zero(value: u8) {
  unsafe { WASM_MEMORY_BUFFER[0] = value; }
}

#[wasm_bindgen]
pub fn get_wasm_memory_buffer_pointer() -> *const u8 {
  let pointer: *const u8;
  unsafe { pointer = WASM_MEMORY_BUFFER.as_ptr(); }
  return pointer;
}
```