// DOCS: https://wasmbyexample.dev/examples/webassembly-linear-memory/webassembly-linear-memory.rust.en-us.html
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