import('./pkg').then(wasm => {
    console.log('wasm.answer()',    wasm.answer());
    console.log('wasm.squared(42)', wasm.squared(42));
    console.log('wasm.add(1,2)',    wasm.add(1,2));
});