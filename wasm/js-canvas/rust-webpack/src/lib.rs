use wasm_bindgen::prelude::*;


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

// DOCS: https://rustwasm.github.io/wasm-bindgen/reference/types/string.html
// requires: npm install text-encoding
#[wasm_bindgen]
pub fn hello_string(name: String) -> String {
    // let output = format!("Hello {name}!"); // IntelliJ Warning: Parameter `name` is never used
    let output = format!("Hello {}!", name);
    return output;
}

// DOCS: https://zyghost.com/guides/intro-to-rust-web/2_web_sys_alert.html
#[wasm_bindgen]
pub fn alert() -> Result<(), JsValue> {
    use web_sys::window;
    let window = window().unwrap();
    window.alert_with_message("Hello from WASM!")
}