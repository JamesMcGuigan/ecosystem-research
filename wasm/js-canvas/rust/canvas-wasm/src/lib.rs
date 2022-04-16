use wasm_bindgen::prelude::*;

// // Called when the wasm module is instantiated
// // Source: https://rustwasm.github.io/docs/wasm-bindgen/examples/without-a-bundler.html
// #[wasm_bindgen(start)]
// pub fn main() -> Result<(), JsValue> {
//     //// Use `web_sys`'s global `window` function to get a handle on the global window object.
//     let window   = web_sys::window().expect("no global `window` exists");
//     let document = window.document().expect("should have a document on window");
//     let body     = document.body().expect("document should have a body");
//
//     // Manufacture the element we're gonna append
//     let val = document.create_element("p")?;
//     val.set_inner_html("Hello from Rust!");
//
//     body.append_child(&val)?;
//
//     Ok(())
// }


/** Static Functions **/

#[wasm_bindgen]
pub fn answer() -> i32 {
    return 42;
}

#[wasm_bindgen]
pub fn squared(x: i32) -> i32 {
    return x * x;
}

#[wasm_bindgen]
pub fn add_two_ints (a: i32, b: i32) -> i32 {
    return a + b;
}


/** Two Way Binding with Javascript Functions **/

#[wasm_bindgen]
extern {
    pub fn alert(s: &str);
}

#[wasm_bindgen]
pub fn greet(name: &str) {
    alert(&format!("Hello, {}!", name));
}