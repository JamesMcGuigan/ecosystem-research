#!/bin/bash
cd $(dirname $BASH_SOURCE[0]);  # cd current directory
set -x


# Error: no export named indexForPosition / offsetForPosition found
wasmtime checkers.wasm --invoke indexForPosition  1 2  # == (1 + 2*8)
wasmtime checkers.wasm --invoke offsetForPosition 1 2  # == (1 + 2*8)+4 = 68
