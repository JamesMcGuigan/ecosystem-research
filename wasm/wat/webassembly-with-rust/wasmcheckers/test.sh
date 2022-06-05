#!/bin/bash
cd $(dirname $BASH_SOURCE[0]);  # cd current directory
set -x

# BUG: wasttime method of calling functions breaks when wat imports are defined
BLACK=1
WHITE=2
CROWN=4

# Error: no export named indexForPosition / offsetForPosition found
wasmtime checkers.wasm --invoke indexForPosition  1 2  2> /dev/null  # == (1 + 2*8)   = 17
wasmtime checkers.wasm --invoke offsetForPosition 1 2  2> /dev/null  # == (1 + 2*8)+4 = 68
wasmtime checkers.wasm --invoke isBlack $BLACK         2> /dev/null
wasmtime checkers.wasm --invoke isBlack $WHITE         2> /dev/null
wasmtime checkers.wasm --invoke isWhite $BLACK         2> /dev/null
wasmtime checkers.wasm --invoke isWhite $WHITE         2> /dev/null
wasmtime checkers.wasm --invoke isCrowned $(wasmtime checkers.wasm --invoke withCrown    $BLACK 2> /dev/null )  2> /dev/null
wasmtime checkers.wasm --invoke isCrowned $(wasmtime checkers.wasm --invoke withoutCrown $WHITE 2> /dev/null )  2> /dev/null