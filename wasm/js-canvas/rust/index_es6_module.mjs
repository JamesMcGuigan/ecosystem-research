import init, { answer, squared, add_two_ints, greet, render_canvas } from './wasm-pack/web/canvas_wasm.js';
async function main() {
    console.warn("index_es6_module.mjs");
    let wasm = await init();

    // console.log('web |', `answer() = ${answer()}`);
    // console.log('web |', `squared(42) = ${squared(42)}`);
    // console.log('web |', `add_two_ints(1,2) = ${add_two_ints(1,2)}`);
    // greet('web | ./canvas-wasm/wasm-pack/web/canvas_wasm.js')

    window.addEventListener('resize', onWindowResize.bind(null, wasm));
    onWindowResize(wasm);
}
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
    console.log(`es6::canvas_wasm.js::render_canvas( ${canvas.width} x ${canvas.height} ): ${timeTaken}ms`)
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
main();