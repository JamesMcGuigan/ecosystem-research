use wasm_bindgen::prelude::*;

// DOCS: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/WebAssembly/Memory
// DOCS: https://wasmbyexample.dev/examples/webassembly-linear-memory/webassembly-linear-memory.rust.en-us.html
const CANVAS_MAX_HEIGHT: usize = 1920;
const CANVAS_MAX_WIDTH:  usize = 1080;
const WASM_MEMORY_BUFFER_SIZE: usize = CANVAS_MAX_HEIGHT * CANVAS_MAX_WIDTH;
static mut WASM_MEMORY_BUFFER: [u32; WASM_MEMORY_BUFFER_SIZE] = [0; WASM_MEMORY_BUFFER_SIZE];

#[allow(dead_code)] const RED:   u32 = 0xFF0000FF;  // alpha = 255 | blue = 0   | green = 0   | red = 255
#[allow(dead_code)] const GREEN: u32 = 0xFF00FF00;  // alpha = 255 | blue = 0   | green = 255 | red = 0
#[allow(dead_code)] const BLUE:  u32 = 0xFFFF0000;  // alpha = 255 | blue = 255 | green = 0   | red = 0
fn rbga(r: u8, b: u8, g: u8, a: u8) -> u32 {
    let color: u32 = ((a as u32) << 24) | ((b as u32) << 16) | ((g as u32) << 8) | ((r as u32) << 0);
    return color;
}

#[wasm_bindgen]
pub fn get_wasm_memory_buffer_pointer() -> *const u32 {
    let pointer: *const u32;
    unsafe {
        pointer = WASM_MEMORY_BUFFER.as_ptr();
    }
    return pointer;
}

#[wasm_bindgen]
pub fn render_canvas(width: i32, height: i32) -> *const u32 {
    for y in 0..height {
        let yw = y * width;
        for x in 0..width {
            let r: u8 = (255. * y as f32 / height as f32) as u8;
            let b: u8 = (255. * x as f32 / width  as f32) as u8;
            let g: u8 = 0;
            let a: u8 = 255;
            let color: u32 = rbga(r,b,g,a);
            // int color = GREEN;
            // int color = (a << 24) | (b << 16) | (g << 8) | (r << 0);
            unsafe {
                let pixel: usize = (yw + x) as usize;
                WASM_MEMORY_BUFFER[pixel] = color;
            }
        }
    }
    unsafe {
        return WASM_MEMORY_BUFFER.as_ptr();  // return pointer
    }
}
