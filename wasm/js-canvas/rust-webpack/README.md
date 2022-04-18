# Javascript WASM via Rust Webpack

Examples: https://github.com/rustwasm/wasm-bindgen

## Install
```
rm -rvf node_modules/ dist/ pkg/ target/
npm install
cargo build
webpack build
webpack serve
```

## Output

- `./node_modules/` - javascript libraries from `npm install`
- `./target/` - compiled rust + wasm from `cargo build`
- `./pkg/` - `wasm-bindgen` wasm from `webpack build` 
  - accessed in JS via `import('./pkg').then(wasm => {})` 
- `./dist/` - static webserver output from `webpack build` 


## Performance

- The C implemention using a predefined WASM array takes about ~20ms to render
- The Rust implemention takes about ~1000ms to render
- Unsure why there is a 200x performance penalty for using Rust bindings 

