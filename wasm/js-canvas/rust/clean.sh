#!/bin/bash
cd "$(dirname "${BASH_SOURCE[0]}")"  # cd current directory
# cd canvas-wasm
set -x

rm -rvf ./target/
rm -rvf ./wasm-pack/