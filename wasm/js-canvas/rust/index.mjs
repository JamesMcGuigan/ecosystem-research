import init, { answer, squared, add_two_ints, greet } from './wasm-pack/web/canvas_wasm.js';
async function run() {
    console.warn("import init, { answer, squared, add_two_ints, greet } from './wasm-pack/web/canvas_wasm.js';")
    await init();

    console.log('web |', `answer() = ${answer()}`);
    console.log('web |', `squared(42) = ${squared(42)}`);
    console.log('web |', `add_two_ints(1,2) = ${add_two_ints(1,2)}`);
    greet('web | ./wasm-pack/web/canvas_wasm.js')
}
run();