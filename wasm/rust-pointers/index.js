// DOCS: https://wasmbyexample.dev/examples/webassembly-linear-memory/webassembly-linear-memory.rust.en-us.html
for( let wasm_file of [
	// "./target/wasm32-unknown-unknown/release/rust_pointers.wasm",
	"./target/wasm32-unknown-unknown/release/bindgen/rust_pointers_bg.wasm",  // Works
	// "./target/wasm32-unknown-unknown/release/deps/rust_pointers.wasm",
	// "./target/wasm32-unknown-unknown/debug/rust_pointers.wasm",
	"./target/wasm32-unknown-unknown/debug/bindgen/rust_pointers_bg.wasm",    // Works
	// "./target/wasm32-unknown-unknown/debug/deps/rust_pointers.wasm",
]) {
    WebAssembly.instantiateStreaming(fetch(wasm_file), {})
    .then(wasm_module => { console.warn(wasm_file); return wasm_module.instance.exports; })
    .then(wasm => {
        let memory = new Uint8Array(wasm.memory.buffer);    // Rust allocates 1114112 bytes = ~1.114Mb by default
        console.log('memory', memory);

        // Define Rust array in WASM memory and return a pointer to Javascript
        let value = wasm.answer();
        wasm.store_value_in_wasm_memory_buffer_index_zero(value);
        let array_pointer = wasm.get_wasm_memory_buffer_pointer(); // 1048584 | 1050664
        console.log(`rust array  | pointer`, array_pointer);
        console.log(`rust array  | memory[${array_pointer}] =`, memory[array_pointer]);

        // Define Rust vector in WASM memory and return a pointer to Javascript
        // BUG: Pointer doesn't seem to reference any useable memory - this approach to returning vectors doesn't work!
        wasm.generate_wasm_vector(42);
        let vec_pointer = wasm.get_wasm_memory_vector_pointer();
        let vec_length  = wasm.get_wasm_memory_vector_length();   // should be 42
        console.log(`rust vector | pointer`, vec_pointer, 'length', vec_length, 'valid', vec_pointer+vec_length <= memory.length);
        console.log(`rust vector | memory[${vec_pointer}] =`, memory[vec_pointer]);  // BUG: memory[vec_pointer] == undefined
        // BUG: TypeError: Cannot perform %TypedArray%.prototype.slice on a detached ArrayBuffer
        console.log(`rust vector | memory[${vec_pointer}..+${vec_length}] =`, memory.slice(vec_pointer, vec_length));

    })
    .catch((error) => console.error(wasm_file, error))
}

