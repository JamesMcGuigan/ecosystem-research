// DOCS: https://compile.fi/canvas-filled-three-ways-js-webassembly-and-webgl/
// DOCS: https://developer.mozilla.org/en-US/docs/WebAssembly/Loading_and_running
// DOCS: https://rustwasm.github.io/docs/wasm-bindgen/

// DOCS: https://rustwasm.github.io/docs/wasm-bindgen/examples/without-a-bundler.html
// $ wasm-pack build --release --target no-modules
// <script type="text/javascript" src="wasm-pack/no-modules/canvas_wasm.js"></script>
wasm_bindgen('./wasm-pack/no-modules/canvas_wasm_bg.wasm').then((wasm) => {
    console.warn("wasm_bindgen('./wasm-pack/no-modules/canvas_wasm_bg.wasm').then((wasm) => {})")
    const { answer, squared, add_two_ints } = wasm;
    console.log('no-modules |', `answer() = ${answer()}`);
    console.log('no-modules |', `squared(42) = ${squared(42)}`);
    console.log('no-modules |', `add_two_ints(1,2) = ${add_two_ints(1,2)}`);
    wasm.greet.call("no-modules | wasm.greet()");             // wasm.greet() is broken ???
    wasm_bindgen.greet("no-modules: wasm_bindgen.greet()");  // greet() requires exactly one argument
});

// // find ./ -name '*.wasm'
// const wasmURLs = [
//     "./pkg/canvas_wasm_bg.wasm",
//     "./target/wasm32-unknown-unknown/release/deps/canvas_wasm.wasm",
//     "./target/wasm32-unknown-unknown/release/canvas_wasm.wasm",
//     "./target/wasm32-unknown-unknown/release/bindgen/canvas_wasm_bg.wasm",
//     "./target/wasm32-unknown-unknown/release/wasm-bindgen/canvas_wasm_bg.wasm",
//     "./target/wasm32-unknown-unknown/debug/deps/canvas_wasm.wasm",
//     "./target/wasm32-unknown-unknown/debug/deps/wasm-bindgen/canvas_wasm_bg.wasm",
//     "./target/wasm32-unknown-unknown/debug/deps/wasm-bindgen/wasm-bindgen/canvas_wasm_bg_bg.wasm",
//     "./target/wasm32-unknown-unknown/debug/deps/wasm-bindgen/wasm-bindgen/wasm-bindgen/canvas_wasm_bg_bg_bg.wasm",
//     "./target/wasm32-unknown-unknown/debug/canvas_wasm.wasm",
//     "./target/wasm32-unknown-unknown/debug/bindgen/canvas_wasm_bg.wasm",
//     "./target/wasm32-unknown-unknown/debug/wasm-bindgen/canvas_wasm_bg.wasm",
//     "./target/wasm32-unknown-unknown/debug/wasm-bindgen/wasm-bindgen/canvas_wasm_bg_bg.wasm",
//     "./target/wasm32-unknown-unknown/debug/wasm-bindgen/wasm-bindgen/wasm-bindgen/canvas_wasm_bg_bg_bg.wasm",
// ];
// wasmURLs.forEach(wasmURL => {
//     // BUG: Uncaught (in promise) TypeError: WebAssembly.instantiate():
//     //      Import #0 module="__wbindgen_placeholder__" error: module is not an object or function Promise.then (async) (anonymous) @ index.js:14
//     WebAssembly.instantiateStreaming(fetch(wasmURL), {})
//         .then(wasm => {
//             console.info('Success:', wasmURL);
//             const { answer, squared, add_two_ints, greet }       = wasm.instance.exports;
//             console.log("wasm.instance.exports.answer()",          wasm.instance.exports.answer());
//             console.log("wasm.instance.exports.squared(42)",       wasm.instance.exports.squared(42));
//             console.log("wasm.instance.exports.add_two_ints(1,2)", wasm.instance.exports.add_two_ints(1,2));
//         })
//         .catch(error => {
//             console.error(wasmURL, "\n", error);
//         })
//     ;
//
//     // index.js:34 ./pkg/canvas_wasm_bg.wasm
//     // TypeError: WebAssembly.instantiate(): Import #0 module="wbg" error: module is not an object or function
//     // index.js:34 ./target/wasm32-unknown-unknown/release/deps/canvas_wasm.wasm
//     // TypeError: WebAssembly.instantiate(): Import #0 module="__wbindgen_placeholder__" error: module is not an object or function
//     // index.js:34 ./target/wasm32-unknown-unknown/release/canvas_wasm.wasm
//     // TypeError: WebAssembly.instantiate(): Import #0 module="__wbindgen_placeholder__" error: module is not an object or function
//     // index.js:34 ./target/wasm32-unknown-unknown/release/bindgen/canvas_wasm_bg.wasm
//     // TypeError: WebAssembly.instantiate(): Import #0 module="./canvas_wasm_bg.js" error: module is not an object or function
//     // index.js:34 ./target/wasm32-unknown-unknown/debug/deps/canvas_wasm.wasm
//     // TypeError: WebAssembly.instantiate(): Import #0 module="__wbindgen_placeholder__" error: module is not an object or function
//     // index.js:34 ./target/wasm32-unknown-unknown/release/wasm-bindgen/canvas_wasm_bg.wasm
//     // TypeError: WebAssembly.instantiate(): Import #0 module="./canvas_wasm_bg.js" error: module is not an object or function
//     // index.js:34 ./target/wasm32-unknown-unknown/debug/deps/wasm-bindgen/canvas_wasm_bg.wasm
//     // TypeError: WebAssembly.instantiate(): Import #0 module="./canvas_wasm_bg.js" error: module is not an object or function
//     // index.js:34 ./target/wasm32-unknown-unknown/debug/deps/wasm-bindgen/wasm-bindgen/wasm-bindgen/canvas_wasm_bg_bg_bg.wasm
//     // TypeError: WebAssembly.instantiate(): Import #0 module="./canvas_wasm_bg.js" error: module is not an object or function
//     // index.js:34 ./target/wasm32-unknown-unknown/debug/deps/wasm-bindgen/wasm-bindgen/canvas_wasm_bg_bg.wasm
//     // TypeError: WebAssembly.instantiate(): Import #0 module="./canvas_wasm_bg.js" error: module is not an object or function
//     // index.js:34 ./target/wasm32-unknown-unknown/debug/canvas_wasm.wasm
//     // TypeError: WebAssembly.instantiate(): Import #0 module="__wbindgen_placeholder__" error: module is not an object or function
//     // index.js:34 ./target/wasm32-unknown-unknown/debug/bindgen/canvas_wasm_bg.wasm
//     // TypeError: WebAssembly.instantiate(): Import #0 module="./canvas_wasm_bg.js" error: module is not an object or function
//     // index.js:34 ./target/wasm32-unknown-unknown/debug/wasm-bindgen/canvas_wasm_bg.wasm
//     // TypeError: WebAssembly.instantiate(): Import #0 module="./canvas_wasm_bg.js" error: module is not an object or function
//     // index.js:34 ./target/wasm32-unknown-unknown/debug/wasm-bindgen/wasm-bindgen/canvas_wasm_bg_bg.wasm
//     // TypeError: WebAssembly.instantiate(): Import #0 module="./canvas_wasm_bg.js" error: module is not an object or function
//     // index.js:34 ./target/wasm32-unknown-unknown/debug/wasm-bindgen/wasm-bindgen/wasm-bindgen/canvas_wasm_bg_bg_bg.wasm
//     // TypeError: WebAssembly.instantiate(): Import #0 module="./canvas_wasm_bg.js" error: module is not an object or function
// });


// // BUG: Failed to load module script: Expected a JavaScript module script but the server responded with a MIME type of "application/wasm".
// //          Strict MIME type checking is enforced for module scripts per HTML spec.
// //      index.js:25 TypeError: Failed to fetch dynamically imported module:
// //          http://localhost:63342/ecosystem-research/wasm/js-canvas/rust/target/wasm32-unknown-unknown/release/wasm-bindgen/canvas_wasm_bg.js
// import('./target/wasm32-unknown-unknown/release/wasm-bindgen/canvas_wasm_bg.js')
//     .then(m => m.greet('World!'))
//     .catch((error) => console.error(error));


// // TypeError: Cannot read properties of undefined (reading '__wbindgen_malloc')
// const wasm = import('./pkg/canvas_wasm.js')
// wasm.then(m => {
//     debugger
//     console.log('m.answer()4', m.answer())
// })
// .catch((error) => console.error(error));