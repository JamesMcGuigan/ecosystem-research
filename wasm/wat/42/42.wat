;;; Source: https://blog.ttulka.com/learning-webassembly-1-hello-world-of-wasm
(module
  (func (export "main")
        (result i32)
    i32.const 42
    return))
