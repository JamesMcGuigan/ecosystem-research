#!/usr/bin/env bats
BLACK=1
WHITE=2
CROWN=4

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


@test "isBlack(\$BLACK)" {
    result=$( wasmtime checkers.wasm --invoke isBlack $BLACK )
    echo \$result $result
    [ $result -eq 1 ]  # == True
}
@test "isBlack(\$WHITE)" {
    result=$( wasmtime checkers.wasm --invoke isBlack $WHITE )
    echo \$result $result
    [ $result -eq 0 ]  # == False
}
@test "isWhite(\$BLACK)" {
    result=$( wasmtime checkers.wasm --invoke isWhite $BLACK )
    echo \$result $result
    [ $result -eq 0 ]  # == False
}
@test "isWhite(\$WHITE)" {
    result=$( wasmtime checkers.wasm --invoke isWhite $WHITE )
    echo \$result $result
    [ $result -eq 1 ]  # == True
}


@test "withCrown == isCrowned" {
    piece=$(  wasmtime checkers.wasm --invoke withCrown $BLACK )
    result=$( wasmtime checkers.wasm --invoke isCrowned $piece )
    echo \$result $result
    [ $result -eq 1 ]  # == True
}
@test "withoutCrown != isCrowned" {
    piece=$(  wasmtime checkers.wasm --invoke withoutCrown $WHITE )
    result=$( wasmtime checkers.wasm --invoke isCrowned $piece )
    echo \$result $result
    [ $result -eq 0 ]  # == True
}
