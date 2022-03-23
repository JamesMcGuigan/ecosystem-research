# WASM

## Reading

Books:
- [WebAssembly for Cloud: A Basic Guide for Wasm-Based Cloud Apps
](https://learning.oreilly.com/library/view/webassembly-for-cloud/9781484274965/)

DOCS:
- https://webassembly.org/getting-started/developers-guide/
- https://webassembly.org/getting-started/advanced-tools/
- https://blog.ttulka.com/learning-webassembly-series

Utilities:
- WASI System Interface API - https://github.com/WebAssembly/WASI
- WASM VM for Cloud - https://wasmedge.org/
- IntelliJ Plugin - https://www.jetbrains.com/help/idea/webassembly-project.html
- Emscripten - LLVM compiler toolchain to WebAssembly - https://emscripten.org/

## Install
```
sudo pacman -S  wabt wasmtime wasmer emscripten # Arch Linux
brew install    wabt wasmtime wasmer emscripten # Homebrew OSX
```

## Commands

```
printf "\x00\x61\x73\x6d\x01\x00\x00\x00" > header.wasm
cat header.wasm              # asm
file header.wasm             # header.wasm: WebAssembly (wasm) binary module version 0x1 (MVP)
hexdump  header.wasm         # 0000000   6100 6d73 0001 0000
wasm-objdump -s header.wasm  # header.wasm:    file format wasm 0x1
wasm2wat header.wasm         # (module)
wasmtime header.wasm         # cli execution = null output
echo $?                      # cli exit code
```
- [header/header.sh](header/header.sh)

```
## WABT Tools: https://github.com/WebAssembly/wabt
wat-desugar    hello_world.wat      # strip comments + flat format syntax)
wat2wasm       hello_world.wat      # compile binary .wasm
file           hello_world.wasm     # hello_world.wasm: WebAssembly (wasm) binary module version 0x1 (MVP)
hexdump        hello_world.wasm     # 0000000   6100 6d73 0001 0000
wasm-objdump   hello_world.wasm -s  # hello_world.wasm:    file format wasm 0x1
wasm2wat       hello_world.wasm     # (module ... (export "memory" (memory 0)) (export "_start" (func 1)))
wasm-decompile hello_world.wasm     # transpile to C (pseudocode)
wasm2c         hello_world.wasm     # transpile to C (long version)
wasm-validate  hello_world.wasm -v  # BeginExportSection EndExportSection

## Unit Tests
## TODO: generate WASM Spec Test .wast
# wast2json       -v hello_world.wast  # convert wasm spec test format to a JSON + wasm file
# spectest-interp -v hello_world.json  # read a Spectest JSON file, and run its tests in the interpreter

## Compare Runtimes: https://blog.logrocket.com/webassembly-runtimes-compared/
wasm-interp hello_world.wasm --run-all-exports  # error initializing module: invalid import "wasi_unstable.fd_write"
wasmtime    hello_world.wasm                    # execute "hello world"
wasmer      hello_world.wasm                    # execute "hello world"
# lucet = https://github.com/bytecodealliance/lucet
# WebAssembly Micro Runtime (WAMR) = https://github.com/bytecodealliance/wasm-micro-runtime
```
- [wat/hello_world/hello_world.sh](wat/print_hello_world/hello_world.sh)