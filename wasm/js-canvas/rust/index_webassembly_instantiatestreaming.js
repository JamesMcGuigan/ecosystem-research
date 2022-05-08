// DOCS: https://compile.fi/canvas-filled-three-ways-js-webassembly-and-webgl/
// DOCS: https://developer.mozilla.org/en-US/docs/WebAssembly/Loading_and_running
// DOCS: https://rustwasm.github.io/docs/wasm-bindgen/

// BUG: For some reason this is broken, but /wasm/rust-pointers/ works
// BUG: WebAssembly.instantiate(): Import #0 module="__wbindgen_placeholder__" error: module is not an object or function
for( let wasm_file of [
	"./target/wasm32-unknown-unknown/release/wasm-bindgen/canvas_wasm_bg.wasm",
	"./target/wasm32-unknown-unknown/release/canvas_wasm.wasm",
	"./target/wasm32-unknown-unknown/release/bindgen/canvas_wasm_bg.wasm",
	"./target/wasm32-unknown-unknown/release/deps/canvas_wasm.wasm",
	"./target/wasm32-unknown-unknown/debug/wasm-bindgen/canvas_wasm_bg.wasm",
	"./target/wasm32-unknown-unknown/debug/canvas_wasm.wasm",
	"./target/wasm32-unknown-unknown/debug/bindgen/canvas_wasm_bg.wasm",
	"./target/wasm32-unknown-unknown/debug/deps/canvas_wasm.wasm",
	"./wasm-pack/nodejs/canvas_wasm_bg.wasm",
	"./wasm-pack/web/canvas_wasm_bg.wasm",
	"./wasm-pack/no-modules/canvas_wasm_bg.wasm",
]) {
    WebAssembly.instantiateStreaming(fetch(wasm_file), {})
	.then(wasm_module => {
		console.warn(wasm_file);
		const wasm = wasm_module.instance.exports;
		console.log('web |', `answer() = ${answer()}`);
		console.log('web |', `squared(42) = ${squared(42)}`);
		console.log('web |', `add_two_ints(1,2) = ${add_two_ints(1,2)}`);
		// greet('web | ./  canvas-wasm/wasm-pack/web/canvas_wasm.js')

		window.addEventListener('resize', onWindowResize.bind(null, wasm));
		onWindowResize(wasm);
	})
	.catch((error) => console.error('index_webassembly_instantiatestreaming.js\n', wasm_file, '\n', error))
}

// Port of C implementation: wasm/js-canvas/c/index.js
function onWindowResize(wasm) {
    const timeStart = Date.now();
    const canvas  = document.getElementById('canvas-wasm-test');
    const ctx     = canvas.getContext('2d');
    resizeCanvasToWindow(canvas);

    const pointer = wasm.render_canvas(canvas.width, canvas.height);  // Rust = ~1000ms | C = ~20ms
    const data    = new Uint8ClampedArray(wasm.memory.buffer, pointer, canvas.width * canvas.height * 4);
    const img     = new ImageData(data, canvas.width, canvas.height);

    ctx.putImageData(img, 0, 0);
    const timeTaken = Date.now() - timeStart;
    console.log(`wasm::render_canvas( ${canvas.width} x ${canvas.height} ): ${timeTaken}ms`)
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