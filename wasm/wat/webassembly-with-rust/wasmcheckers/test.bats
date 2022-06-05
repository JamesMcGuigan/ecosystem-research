#!/usr/bin/env bats

@test "indexForPosition  1 2 == 17" {
    result=$( wasmtime checkers.wasm --invoke indexForPosition  1 2 )
    echo \$result $result
    [ $result -eq 17 ]  # == (1 + 2*8)
}

@test "offsetForPosition 1 2 == 68" {
    result=$( wasmtime checkers.wasm --invoke offsetForPosition  1 2 )
    echo \$result $result
    [ $result -eq 68 ]  # == (1 + 2*8) * 4
}