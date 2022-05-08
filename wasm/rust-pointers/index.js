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
        // Define WASM memory in Rust and return a pointer to Javascript
        let value = wasm.answer();
        wasm.store_value_in_wasm_memory_buffer_index_zero(value);
        let memory  = new Uint8Array(wasm.memory.buffer);    // Rust allocates 1114112 bytes = ~1.114Mb by default
        let pointer = wasm.get_wasm_memory_buffer_pointer(); // 1048584 | 1050664
        console.log(`rust memory[${pointer}] =`, memory[pointer], memory);
    })
    .catch((error) => console.error(wasm_file, error))
}

