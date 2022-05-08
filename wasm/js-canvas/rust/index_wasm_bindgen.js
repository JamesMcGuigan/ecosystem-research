// HTML requirement: <script type="text/javascript" src="wasm-pack/no-modules/canvas_wasm.js"></script>
for( let wasm_file of [
    // "./target/wasm32-unknown-unknown/release/wasm-bindgen/canvas_wasm_bg.wasm",
    // "./target/wasm32-unknown-unknown/release/canvas_wasm.wasm",
    // "./target/wasm32-unknown-unknown/release/bindgen/canvas_wasm_bg.wasm",
    // "./target/wasm32-unknown-unknown/release/deps/canvas_wasm.wasm",
    // "./target/wasm32-unknown-unknown/debug/wasm-bindgen/canvas_wasm_bg.wasm",
    // "./target/wasm32-unknown-unknown/debug/canvas_wasm.wasm",
    // "./target/wasm32-unknown-unknown/debug/bindgen/canvas_wasm_bg.wasm",
    // "./target/wasm32-unknown-unknown/debug/deps/canvas_wasm.wasm",
    // "./wasm-pack/nodejs/canvas_wasm_bg.wasm",
    "./wasm-pack/web/canvas_wasm_bg.wasm",          // WORKS
    "./wasm-pack/no-modules/canvas_wasm_bg.wasm",   // WORKS
]) {
    wasm_bindgen(wasm_file).then(wasm => {
        console.warn(`index_wasm_bindgen.js | ${wasm_file}`);
        // console.log('web |', `answer() = ${wasm.answer()}`);
        // console.log('web |', `squared(42) = ${wasm.squared(42)}`);
        // console.log('web |', `add_two_ints(1,2) = ${wasm.add_two_ints(1, 2)}`);
        // greet('web | ./canvas-wasm/wasm-pack/web/canvas_wasm.js')

        window.addEventListener('resize', onWindowResize.bind(null, wasm));
        onWindowResize(wasm);
    });
}

// Port of C implementation: wasm/js-canvas/c/index.js
function onWindowResize(wasm) {
    const timeStart = Date.now();

    const canvas  = document.getElementById('canvas-wasm-test');
    const ctx     = canvas.getContext('2d');

    resizeCanvasToWindow(canvas);

    const pointer = wasm.render_canvas(canvas.width, canvas.height);  // Rust WAS: ~1000ms NOW: ~5ms | C = ~5ms (Apple M1)
    const data    = new Uint8ClampedArray(wasm.memory.buffer, pointer, canvas.width * canvas.height * 4);
    const img     = new ImageData(data, canvas.width, canvas.height);

    ctx.putImageData(img, 0, 0);

    const timeTaken = Date.now() - timeStart;
    console.log(`index_wasm_bindgen.js::render_canvas( ${canvas.width} x ${canvas.height} ): ${timeTaken}ms`)
}

function resizeCanvasToWindow(canvas) {
    // resize canvas to window
    if (window.innerHeight !== canvas.height || window.innerWidth !== canvas.width) {
        canvas.height       = window.innerHeight;
        canvas.style.height = window.innerHeight;
        canvas.width        = window.innerWidth;
        canvas.style.width  = window.innerWidth;
        // gl.viewport(0, 0, window.innerWidth, window.innerHeight);
    }
}