use wasm_bindgen::prelude::*;

mod array;
mod vector;

#[wasm_bindgen]
pub fn answer() -> i32 {
    return 42;
}
