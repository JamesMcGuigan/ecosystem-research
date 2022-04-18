import('./pkg').then(wasm => {
    console.log('wasm.answer()',    wasm.answer());1
    console.log('wasm.squared(42)', wasm.squared(42));
    console.log('wasm.add(1,2)',    wasm.add(1,2));
    console.log('wasm.hello_string("Jamie")', wasm.hello_string("Jamie"));
    // wasm.alert();

    function renderCanvas() {
        const timeStart = Date.now();
        const canvas  = document.getElementById('color-map');
        const ctx     = canvas.getContext('2d');
        canvas.width  = window.innerWidth;
        canvas.height = window.innerHeight;

        // wasm.draw_julia_set(ctx, canvas.width, canvas.height, -0.15, 0.65);
        wasm.draw_color_map(ctx, canvas.width, canvas.height);

        console.log(`renderCanvas( ${canvas.width} x ${canvas.height} ): ${Date.now() - timeStart}ms`)
    }
    window.addEventListener('resize', renderCanvas);
    renderCanvas();
});