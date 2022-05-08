// DOCS: https://wasmbyexample.dev/examples/webassembly-linear-memory/webassembly-linear-memory.rust.en-us.html
// BUG: Vector will not allocate until elements are pushed onto it
use wasm_bindgen::prelude::*;

static mut WASM_MEMORY_VEC: Vec<u8> = Vec::new();

#[wasm_bindgen]
pub fn generate_wasm_vector(length: usize) {
    unsafe {
        WASM_MEMORY_VEC.clear();
        for i in 0..length as usize {
            WASM_MEMORY_VEC.push(i as u8);
        }
    }
}

#[wasm_bindgen]
pub fn get_wasm_memory_vector_pointer() -> *const u8 {
    let pointer: *const u8;
    unsafe { pointer = WASM_MEMORY_VEC.as_mut_ptr(); }
    return pointer;
}
#[wasm_bindgen]
pub fn get_wasm_memory_vector_length() -> usize {
    unsafe { return WASM_MEMORY_VEC.len(); }
}