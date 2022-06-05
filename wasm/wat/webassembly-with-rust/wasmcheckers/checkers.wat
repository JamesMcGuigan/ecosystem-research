(module
    ;;;; Imports - these break wasmtime bats unit tests
    (import "events" "piecemoved"
        (func $notify_piecemoved (param $fromX i32) (param $fromY i32)
                                 (param $toX i32)   (param $toY i32))
    )
    (import "events" "piececrowned"
        (func $notify_piececrowned (param $pieceX i32) (param $pieceY i32))
    )


    ;;;; Globals
    (memory $mem 1)
    (global $BLACK i32 (i32.const 1))
    (global $WHITE i32 (i32.const 2))
    (global $CROWN i32 (i32.const 4))
    (global $currentTurn (mut i32) (i32.const 0))



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


    ;;;; Keeping Track of the Current Turn

    ;; Gets the current turn owner (white or black)
    (func $getTurnOwner (result i32)
        (global.get $currentTurn)
    )

    ;; At the end of a turn, switch turn owner to the other player
    (func $toggleTurnOwner
        (if
            (i32.eq (call $getTurnOwner) (i32.const 1))
            (then   (call $setTurnOwner (i32.const 2)))
            (else   (call $setTurnOwner (i32.const 1)))
        )
    )

    ;; Sets the turn owner
    (func $setTurnOwner (param $piece i32)
        (global.set $currentTurn (local.get $piece))
    )

    ;; Determine if it's a player's turn
    (func $isPlayersTurn (param $player i32) (result i32)
        (i32.gt_s
            (i32.and (local.get $player) (call $getTurnOwner))
            (i32.const 0)
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



    ;;;; Keeping Track of the Current Turn




    ;;;; Manipulating the Board

    ;; Determine if the move is valid
    (func $isValidMove
        (param $fromX i32) (param $fromY i32)
        (param $toX   i32) (param $toY   i32)
        (result i32)

        (local $player i32)
        (local $target i32)

        (local.set $player (call $getPiece (local.get $fromX) (local.get $fromY) ))
        (local.set $target (call $getPiece (local.get $toX)   (local.get $toY)   ))

        (if (result i32)
            (block (result i32)
                (i32.and
                    (call $validJumpDistance (local.get $fromY) (local.get $toY))
                    (i32.and
                        (call $isPlayersTurn (local.get $player))
                        (i32.eq (local.get $target (i32.const 0)))  ;; target must be unoccupied
                    )
                )
            )
            (then (i32.const 1))
            (else (i32.const 0))
        )
    )


    ;; Ensures travel is 1 or 2 squares
    (func $validJumpDistance (param $from i32) (param $to i32) (result i32)
        (local $d i32)
        (local.set $d
            ;; Choose order of $to + $from based on which is larger
            (if (result i32)
                (i32.gt_s (local.get $to) (local.get $from))
                (then (call $distance (local.get $to)   (local.get $from)) )  ;; if $to < $from
                (else (call $distance (local.get $from) (local.get $to))   )  ;; if $from < $to
            )
        )
        (i32.le_u (local.get $d) (i32.const 2))
    )


    ;; Exported move function to be called by the game host
    (func $move (param $fromX i32) (param $fromY i32)
                (param $toX i32) (param $toY i32)
                (result i32)

        (if (result i32)
            (block (result i32)
                (call $isValidMove (local.get $fromX) (local.get $fromY)
                                   (local.get $toX)   (local.get $toY)
                )
            )
            (then
                (call $do_move (local.get $fromX) (local.get $fromY)
                               (local.get $toX)   (local.get $toY))
            )
            (else
                (i32.const 0)
            )
        )
    )


    ;; Internal move function, performs actual move post-validation of target. ;; Currently not handled:
    ;; - removing opponent piece during a jump
    ;; - detecting win condition
    (func $do_move (param $fromX i32) (param $fromY i32)
                   (param $toX   i32) (param $toY   i32)
                   (result i32)

        (local $curpiece i32)
        (local.set $curpiece (call $getPiece (local.get $fromX) (local.get $fromY)))

        (call $toggleTurnOwner)
        (call $setPiece (local.get $toX)   (local.get $toY)   (local.get $curpiece))
        (call $setPiece (local.get $fromX) (local.get $fromY) (i32.const 0))

        (if       (call $shouldCrown (local.get $toY) (local.get $curpiece))
            (then (call $crownPiece  (local.get $toX) (local.get $toY)))
        )
        (call $notify_piecemoved (local.get $fromX) (local.get $fromY)
                                 (local.get $toX)   (local.get $toY)
        )
        (i32.const 1)
    )



    ;;;; Game Rules

    ;; Should this piece get crowned?
    ;; We crown black pieces in row 0, white pieces in row 7
    (func $shouldCrown (param $toY i32) (param $piece i32) (result i32)
        (if (result i32)
            (i32.or
                (i32.and
                    (i32.eq (local.get $toY) (i32.const 0))
                    (call $isWhite (local.get $piece))
                )
                (i32.and
                    (i32.eq (local.get $toY) (i32.const 7))
                    (call $isBlack (local.get $piece))
                )
            )
            (then (i32.const 1))
            (else (i32.const 0))
        )
    )

    ;; Converts a piece into a crowned piece and invokes a host notifier
    (func $crownPiece (param $x i32) (param $y i32)
        (local $piece i32)
        (local.set $piece
            (call $getPiece (local.get $x) (local.get $y))
        )
        (call $setPiece
            (local.get $x) (local.get $y)
            (call $withCrown (local.get $piece))
        )
        (call $notify_piececrowned (local.get $x) (local.get $y))
    )

    (func $distance (param $x i32) (param $y i32) (result i32)
        (i32.sub (local.get $x) (local.get $y))
    )



    ;;;; Init

    ;; Manually place each piece on the board to initialize the game
    (func $initBoard
        (call $setPiece (i32.const 1) (i32.const 0) (global.get $WHITE))
        (call $setPiece (i32.const 3) (i32.const 0) (global.get $WHITE))
        (call $setPiece (i32.const 5) (i32.const 0) (global.get $WHITE))
        (call $setPiece (i32.const 7) (i32.const 0) (global.get $WHITE))

        (call $setPiece (i32.const 0) (i32.const 1) (global.get $WHITE))
        (call $setPiece (i32.const 2) (i32.const 1) (global.get $WHITE))
        (call $setPiece (i32.const 4) (i32.const 1) (global.get $WHITE))
        (call $setPiece (i32.const 6) (i32.const 1) (global.get $WHITE))

        (call $setPiece (i32.const 1) (i32.const 2) (global.get $WHITE))
        (call $setPiece (i32.const 3) (i32.const 2) (global.get $WHITE))
        (call $setPiece (i32.const 5) (i32.const 2) (global.get $WHITE))
        (call $setPiece (i32.const 7) (i32.const 2) (global.get $WHITE))

        (call $setPiece (i32.const 0) (i32.const 5) (global.get $BLACK))
        (call $setPiece (i32.const 2) (i32.const 5) (global.get $BLACK))
        (call $setPiece (i32.const 4) (i32.const 5) (global.get $BLACK))
        (call $setPiece (i32.const 6) (i32.const 5) (global.get $BLACK))

        (call $setPiece (i32.const 1) (i32.const 6) (global.get $BLACK))
        (call $setPiece (i32.const 3) (i32.const 6) (global.get $BLACK))
        (call $setPiece (i32.const 5) (i32.const 6) (global.get $BLACK))
        (call $setPiece (i32.const 7) (i32.const 6) (global.get $BLACK))

        (call $setPiece (i32.const 0) (i32.const 7) (global.get $BLACK))
        (call $setPiece (i32.const 2) (i32.const 7) (global.get $BLACK))
        (call $setPiece (i32.const 4) (i32.const 7) (global.get $BLACK))
        (call $setPiece (i32.const 6) (i32.const 7) (global.get $BLACK))

        (call $setTurnOwner (global.get $BLACK))  ;; Black goes first - always bet on black!
    )


    ;;;; Exports
    (export "indexForPosition"  (func $indexForPosition))
    (export "offsetForPosition" (func $offsetForPosition))
    (export "isCrowned" (func $isCrowned))
    (export "isWhite" (func $isWhite))
    (export "isBlack" (func $isBlack))
    (export "withCrown" (func $withCrown))
    (export "withoutCrown" (func $withoutCrown))
    (export "getTurnOwner" (func $getTurnOwner))
    (export "toggleTurnOwner" (func $toggleTurnOwner))
    (export "setTurnOwner" (func $setTurnOwner))
    (export "isPlayersTurn" (func $isPlayersTurn))
    (export "setPiece" (func $setPiece))
    (export "getPiece" (func $getPiece))
    ;; (export "inRange" (func $inRange))
    ;; (export "isValidMove" (func $isValidMove))
    ;; (export "validJumpDistance" (func $validJumpDistance))
    (export "move" (func $move))
    ;; (export "do_move" (func $do_move))
    (export "shouldCrown" (func $shouldCrown))
    (export "crownPiece" (func $crownPiece))
    (export "distance" (func $distance))
    (export "initBoard" (func $initBoard))
    (export "memory" (memory $mem))
)