// DOCS: https://compile.fi/canvas-filled-three-ways-js-webassembly-and-webgl/
// DOCS: https://developer.mozilla.org/en-US/docs/WebAssembly/Loading_and_running

// Test Static Functions
WebAssembly.instantiateStreaming(fetch('src/test.c.wasm'), {}).then(wasm => {
    console.warn('Test Static Functions');

    const { answer, squared } = wasm.instance.exports;
    console.log("wasm.instance.exports.answer()",    wasm.instance.exports.answer());
    console.log("wasm.instance.exports.squared(42)", wasm.instance.exports.squared(42));
});

// Pass manual array as argument
WebAssembly.instantiateStreaming(fetch('src/test.c.wasm'), {}).then(wasm => {
    console.warn('Pass manual array as argument');

    const { sumArrayInt32, memory } = wasm.instance.exports
    let array, result;

    // Small manually encoded array
    array = new Int32Array(memory.buffer, 0, 5);
    array.set([3, 15, 18, 4, 3]);
    result = sumArrayInt32(array.byteOffset, array.length)
    console.log(`sum([${array.join(',')}]) = ${result}`);  // == 43

    // Test same array can be called multiple times with different results
    array.set([1, 2, 3, 4, 5]);
    result = sumArrayInt32(array.byteOffset, array.length)
    console.log(`sum([${array.join(',')}]) = ${result}`);  // == 41

    // Resize array and retest
    array = new Int32Array(memory.buffer, 0, 6);
    array.set([1, 2, 3, 4, 5, 6]);
    result = sumArrayInt32(array.byteOffset, array.length)
    console.log(`sum([${array.join(',')}]) = ${result}`);  // == 21

    // Resize array and retest
    array = new Int32Array(memory.buffer, 0, 7);
    array.set([1, 2, 3, 4, 5, 6, 7]);
    result = sumArrayInt32(array.byteOffset, array.length)
    console.log(`sum([${array.join(',')}]) = ${result}`);  // == 21

    // Resize array and retest
    array = new Int32Array(memory.buffer, 0, 8);
    array.set([1, 2, 3, 4, 5, 6, 7, 8]);
    result = sumArrayInt32(array.byteOffset, array.length)
    console.log(`sum([${array.join(',')}]) = ${result}`);  // == 21
});

// Test passing int* = Int32Array() as argument
WebAssembly.instantiateStreaming(fetch('src/test.c.wasm'), {}).then(wasm => {
    console.warn('Test passing int* = Int32Array() as argument');

    const {sumArrayInt32, memory} = wasm.instance.exports
    let array, result, expected;

    // Test how large we can make this array
    // BUG:  size = 2^23 | RangeError: Invalid typed array length: 8388608
    // NOTE: C int returns i32 | negative overflow happens at sum(1..2^16) = -2147450880 = -2^31
    // NOTE: WASM requires array.set() to be explictly called
    for( let n = 0; n <= 22; n+=1 ) {
        let size = Math.pow(2, n);
        array = new Int32Array(memory.buffer, 0, size);
        array.set( Array.from({length: size}, (n,i) => i + 1 ) );
        result   = sumArrayInt32(array.byteOffset, array.length)
        expected = 0 // array.reduce((total, n) => total + n)
        console.log(`i32 | sum(1 .. 2^${n}) = ${result}`, result == expected);
    }
})

// Test passing long* = BigInt64Array() as argument
WebAssembly.instantiateStreaming(fetch('src/test.c.wasm'), {}).then(wasm => {
    console.warn('Test passing long* = BigInt64Array() as argument');

    const {sumArrayInt64, memory} = wasm.instance.exports
    let array, result, expected;

    // Test how large we can make this array
    // BUG:    size = 2^21 | RangeError: Invalid typed array length: 4194304
    // NOTE:   C long returns i32 | negative overflow happens at sum(1..2^16) = -2147450880 = -2^31
    // BUGFIX: long *array <- BigInt64Array() requires size*2 | else it acts as if loop was: n-1
    for( let n = 1; n <= 20; n+=1 ) {
        let size = Math.pow(2, n);
        array    = new BigInt64Array(memory.buffer, 0, size*2);  // BigInt64Array requires size*2
        array.set( Array.from({length: size}, (n,i) => BigInt(i + 1) ) );
        result   = sumArrayInt64(array.byteOffset, array.length);  // C long is still returned as i32
        expected = 0 // array.reduce((total, n) => total + n).valueOf();
        console.log(`i64 | sum(1 .. 2^${n}) = ${result}`, result == expected, expected);
    }
});


// Test returning pointer to predefined WASM array
WebAssembly.instantiateStreaming(fetch('src/test.c.wasm'), {}).then(wasm => {
    console.warn('Test returning pointer to predefined WASM array');

    const { renderCanvas, memory } = wasm.instance.exports;
    const canvas  = document.getElementById('canvas-wasm-test');
    const ctx     = canvas.getContext('2d');
    function onWindowResize() {
        const timeStart = Date.now();
        canvas.width  = window.innerWidth;  // resize canvas to window
        canvas.height = window.innerHeight; // resize canvas to window

        const width   = canvas.width;
        const height  = canvas.height;
        const pointer = renderCanvas(width, height);  // Rust = ~1000ms | C = ~20ms
        const data    = new Uint8ClampedArray(memory.buffer, pointer, width * height * 4);
        const img     = new ImageData(data, width, height);

        ctx.putImageData(img, 0, 0);
        console.log(`C::renderCanvas( ${canvas.width} x ${canvas.height} ): ${Date.now() - timeStart}ms`)
    }
    window.addEventListener('resize', onWindowResize);
    onWindowResize();
});
