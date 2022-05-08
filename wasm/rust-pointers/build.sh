#!/bin/bash

cargo build --target wasm32-unknown-unknown
cargo build --target wasm32-unknown-unknown --release
find ./ -name '*.wasm'   | xargs -t -P0 -L1 -I{} wasm2wat {} -o {}.wat
find ./target/*/*/*.wasm | parallel -v -k -n 1 'wasm-bindgen {1} --out-dir {1//}/bindgen/'