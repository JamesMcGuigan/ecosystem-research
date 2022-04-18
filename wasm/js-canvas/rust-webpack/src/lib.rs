use wasm_bindgen::prelude::*;
// use wasm_bindgen::Clamped;

#[wasm_bindgen]
pub fn answer() -> i32 {
    return 42;
}

#[wasm_bindgen]
pub fn squared(x: i32) -> i32 {
    return x * x;
}

#[wasm_bindgen]
pub fn add(a: i32, b: i32) -> i32 {
    return a + b;
}