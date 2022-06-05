(module
    (export "indexForPosition"  (func $indexForPosition))
    (export "offsetForPosition" (func $offsetForPosition))
    (export "isCrowned" (func $isCrowned))
    (export "isWhite" (func $isWhite))
    (export "isBlack" (func $isBlack))
    (export "withCrown" (func $withCrown))
    (export "withoutCrown" (func $withoutCrown))
    (export "setPiece" (func $setPiece))
    (export "getPiece" (func $getPiece))

    (memory $mem 1)
    (global $BLACK i32 (i32.const 1))
    (global $WHITE i32 (i32.const 2))
    (global $CROWN i32 (i32.const 4))



    ;;;; Coords

    ;; Index = (x + y * 8)
    (func $indexForPosition (param $x i32) (param $y i32) (result i32)
        (i32.add
            (i32.mul
                (i32.const 8)
                (local.get $y)
            )
            (local.get $x)
        )
    )

    ;; Offset = (x + y * 8) * 4
    (func $offsetForPosition (param $x i32) (param $y i32) (result i32)
        (i32.mul
            (call $indexForPosition (local.get $x) (local.get $y))
            (i32.const 4)
        )
    )



    ;;;; Getters

    ;; Determine if a piece has been crowned
    (func $isCrowned (param $piece i32) (result i32)
        (i32.eq
            (i32.and (local.get $piece) (global.get $CROWN))
            (global.get $CROWN)
        )
    )

    ;; Determine if a piece is White
    (func $isWhite (param $piece i32) (result i32)
        (i32.eq
            (i32.and (local.get $piece) (global.get $WHITE))
            (global.get $WHITE)
        )
    )

    ;; Determine if a piece is Black
    (func $isBlack (param $piece i32) (result i32)
        (i32.eq
            (i32.and (local.get $piece) (global.get $BLACK))
            (global.get $BLACK)
        )
    )



    ;;;; Setters

    ;; Adds Crown to given piece (no mutation)
    (func $withCrown (param $piece i32) (result i32)
        (i32.or
            (local.get $piece)
            (global.get $CROWN)
        )
    )

    ;; Remove Crown to given piece (no mutation)
    (func $withoutCrown (param $piece i32) (result i32)
        (i32.and
            (local.get $piece)
            (global.get $CROWN)
        )
    )


    ;;;; Manipulating the Board

    ;; Sets a piece on the board.
    (func $setPiece (param $x i32) (param $y i32) (param $piece i32)
        (i32.store
            (call $offsetForPosition (local.get $x) (local.get $y))
            (local.get $piece)
        )
    )

    ;; Gets a piece from the board - out of range causes a trap
    (func $getPiece (param $x i32) (param $y i32) (result i32)
        (if (result i32)
            (block (result i32)
                (i32.and
                    (call $inRange
                        (i32.const 0)
                        (i32.const 7)
                        (local.get $x)
                    )
                    (call $inRange
                        (i32.const 0)
                        (i32.const 7)
                        (local.get $y)
                    )
                )
            )
            (then
                (i32.load
                    (call $offsetForPosition
                        (local.get $x)
                        (local.get $y)
                    )
                )
            )
            (else
                (unreachable)
            )
        )
    )

    (func $inRange (param $low i32) (param $high i32) (param $value i32) (result i32)
        (i32.and
            (i32.ge_s (local.get $value) (local.get $low))
            (i32.le_s (local.get $value) (local.get $high))
        )
    )

)