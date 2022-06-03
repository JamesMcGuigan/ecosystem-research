#!/usr/bin/env node
const fs = require('fs');

const wasmBuffer = fs.readFileSync('./gcd.wasm');
WebAssembly.instantiate(wasmBuffer).then(wasmModule => {
    let wasm  = wasmModule.instance.exports;
    let [a,b] = process.argv.slice(-2).map(Number);
    let gcd   = wasm.gcd(a,b);
    console.log(`GCD of ${a} and ${b} is ${gcd}`);
});


//// Browser Version 1
// fetch('./gcd.wasm')
//     .then(response => response.arrayBuffer())
//     .then(bytes => WebAssembly.instantiate(bytes, {}))
//     .then(wasmModule => {
//          let wasm  = wasmModule.instance.exports;
//          let [a,b] = process.argv.slice(-2).map(Number);
//          let gcd   = wasm.gcd(a,b);
//          console.log(`GCD of ${a} and ${b} is ${gcd}`);
//     });

//// Browser Version 2
// WebAssembly.instantiateStreaming(fetch('./gcd.wasm'), {}).then(wasmModule => {
//     let wasm  = wasmModule.instance.exports;
//     let [a,b] = process.argv.slice(-2).map(Number);
//     let gcd   = wasm.gcd(a,b);
//     console.log(`GCD of ${a} and ${b} is ${gcd}`);
// });
