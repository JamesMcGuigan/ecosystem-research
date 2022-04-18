use wasm_bindgen::prelude::*;
use wasm_bindgen::Clamped;
use web_sys::CanvasRenderingContext2d;  // Cargo.toml: [dependencies.web-sys] features = [ "CanvasRenderingContext2d", ]
use web_sys::ImageData;                 // Cargo.toml: [dependencies.web-sys] features = [ "ImageData", ]
mod julia_set;

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


#[wasm_bindgen]
pub fn draw_color_map(
    ctx:    &CanvasRenderingContext2d,
    width:  u32,
    height: u32,
) -> Result<(), JsValue> {
    let mut data = get_color_map(width, height);
    let data = ImageData::new_with_u8_clamped_array_and_sh(Clamped(&mut data), width, height)?;
    ctx.put_image_data(&data, 0.0, 0.0)
}

fn get_color_map(width: u32, height: u32) -> Vec<u8> {
    let mut data = Vec::new();
    for y in 0..height {
        for x in 0..width {
            let x_pc = x as f64 / width as f64;
            let y_pc = y as f64 / height as f64;
            let r = 255.0 * x_pc;
            let g = 255.0 * y_pc;
            let b = 255.0 * (x_pc + y_pc) / 2.0;
            let a = 255.0;

            data.push(r as u8);
            data.push(g as u8);
            data.push(b as u8);
            data.push(a as u8);
        }
    }
    return data;
}