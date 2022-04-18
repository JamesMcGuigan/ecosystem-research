# Javascript WASM via Rust Webpack

Examples: https://github.com/rustwasm/wasm-bindgen

## Install
```
rm -rvf node_modules/ dist/ pkg/ target/
npm install
cargo build
webpack build
webpack dev-server
```

## Output

- `./node_modules/` - javascript libraries from `npm install`
- `./target/` - compiled rust + wasm from `cargo build`
- `./pkg/` - `wasm-bindgen` wasm from `webpack build` 
  - accessed in JS via `import('./pkg').then(wasm => {})` 
- `./dist/` - static webserver output from `webpack build` 
