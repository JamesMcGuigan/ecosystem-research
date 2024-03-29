#!/usr/bin/env node
/**
 * This is a handwritten attempt to simplfy the autogenerated code in webp.js
 * Main goal is to call version() and use console.log() to print the return value, rather than importing <stdio.h>
 */

//// This method requires a HTTP XHR request, so breaks node local filesystem
// WebAssembly
//     .instantiateStreaming(fetch('webp.wasm'))
//     .then(({instance}) => {
//         let version = instance.exports.version();
//         console.info('fetch(\'webp.wasm\').exports.version() =', version);
//     });

function wasmInstantiateFilesystem(filename) {
    // Source: https://stackoverflow.com/questions/51451456/how-to-directly-instantiate-webassembly-module-in-javascript
    function asciiToBinary(str) {
        if (typeof atob === 'function') {
            return atob(str)  // this works in the browser
        } else {
            return new Buffer(str, 'base64').toString('binary');  // this works in node
        }
    }
    function decode(encoded) {
        var binaryString =  asciiToBinary(encoded);
        var bytes = new Uint8Array(binaryString.length);
        for (var i = 0; i < binaryString.length; i++) {
            bytes[i] = binaryString.charCodeAt(i);
        }
        return bytes.buffer;
    }
    const readFileSync = require('fs').readFileSync;
    const wasmCode = readFileSync(filename); // ('webp.wasm');
    const encoded = Buffer.from(wasmCode, 'binary').toString('base64');
    const webp = WebAssembly.instantiate(decode(encoded), {});
    return webp;  // returns promise
}

// NOTE: In theory, this should be the same as above, but it seems to run into a dependency issue
wasmInstantiateFilesystem('webp.wasm')
    .then((instance) => {
        console.info('fetch(\'webp.wasm\').exports.version() =', instance.exports.version());
    })
    .catch((error) => {
        // TypeError: WebAssembly.instantiate(): Import #0 module="wasi_snapshot_preview1" error: module is not an object or function
        console.error(error);
    })