(module
  (type (;0;) (func (param i32 i32 i32 i32)))
  (type (;1;) (func (param i32 i32)))
  (type (;2;) (func (param i32 i32) (result i32)))
  (type (;3;) (func (param i32) (result i32)))
  (type (;4;) (func (result i32)))
  (type (;5;) (func))
  (type (;6;) (func (param i32)))
  (type (;7;) (func (param i32 i32 i32)))
  (type (;8;) (func (param i32 i32 i32) (result i32)))
  (type (;9;) (func (param i32 i32 i32 i32) (result i32)))
  (import "events" "piecemoved" (func (;0;) (type 0)))
  (import "events" "piececrowned" (func (;1;) (type 1)))
  (func (;2;) (type 2) (param i32 i32) (result i32)
    i32.const 8
    local.get 1
    i32.mul
    local.get 0
    i32.add)
  (func (;3;) (type 2) (param i32 i32) (result i32)
    local.get 0
    local.get 1
    call 2
    i32.const 4
    i32.mul)
  (func (;4;) (type 3) (param i32) (result i32)
    local.get 0
    global.get 2
    i32.and
    global.get 2
    i32.eq)
  (func (;5;) (type 3) (param i32) (result i32)
    local.get 0
    global.get 1
    i32.and
    global.get 1
    i32.eq)
  (func (;6;) (type 3) (param i32) (result i32)
    local.get 0
    global.get 0
    i32.and
    global.get 0
    i32.eq)
  (func (;7;) (type 3) (param i32) (result i32)
    local.get 0
    global.get 2
    i32.or)
  (func (;8;) (type 3) (param i32) (result i32)
    local.get 0
    global.get 2
    i32.and)
  (func (;9;) (type 4) (result i32)
    global.get 3)
  (func (;10;) (type 5)
    call 9
    i32.const 1
    i32.eq
    if  ;; label = @1
      i32.const 2
      call 11
    else
      i32.const 1
      call 11
    end)
  (func (;11;) (type 6) (param i32)
    local.get 0
    global.set 3)
  (func (;12;) (type 3) (param i32) (result i32)
    local.get 0
    call 9
    i32.and
    i32.const 0
    i32.gt_s)
  (func (;13;) (type 7) (param i32 i32 i32)
    local.get 0
    local.get 1
    call 3
    local.get 2
    i32.store)
  (func (;14;) (type 2) (param i32 i32) (result i32)
    block (result i32)  ;; label = @1
      i32.const 0
      i32.const 7
      local.get 0
      call 15
      i32.const 0
      i32.const 7
      local.get 1
      call 15
      i32.and
    end
    if (result i32)  ;; label = @1
      local.get 0
      local.get 1
      call 3
      i32.load
    else
      unreachable
    end)
  (func (;15;) (type 8) (param i32 i32 i32) (result i32)
    local.get 2
    local.get 0
    i32.ge_s
    local.get 2
    local.get 1
    i32.le_s
    i32.and)
  (func (;16;) (type 9) (param i32 i32 i32 i32) (result i32)
    (local i32 i32)
    local.get 0
    local.get 1
    call 14
    local.set 4
    local.get 2
    local.get 3
    call 14
    local.set 5
    block (result i32)  ;; label = @1
      local.get 1
      local.get 3
      call 17
      local.get 4
      call 12
      i32.const 0
      local.get 5
      i32.eq
      i32.and
      i32.and
    end
    if (result i32)  ;; label = @1
      i32.const 1
    else
      i32.const 0
    end)
  (func (;17;) (type 2) (param i32 i32) (result i32)
    (local i32)
    local.get 1
    local.get 0
    i32.gt_s
    if (result i32)  ;; label = @1
      local.get 1
      local.get 0
      call 22
    else
      local.get 0
      local.get 1
      call 22
    end
    local.set 2
    local.get 2
    i32.const 2
    i32.le_u)
  (func (;18;) (type 9) (param i32 i32 i32 i32) (result i32)
    block (result i32)  ;; label = @1
      local.get 0
      local.get 1
      local.get 2
      local.get 3
      call 16
    end
    if (result i32)  ;; label = @1
      local.get 0
      local.get 1
      local.get 2
      local.get 3
      call 19
    else
      i32.const 0
    end)
  (func (;19;) (type 9) (param i32 i32 i32 i32) (result i32)
    (local i32)
    local.get 0
    local.get 1
    call 14
    local.set 4
    call 10
    local.get 2
    local.get 3
    local.get 4
    call 13
    local.get 0
    local.get 1
    i32.const 0
    call 13
    local.get 3
    local.get 4
    call 20
    if  ;; label = @1
      local.get 2
      local.get 3
      call 21
    end
    local.get 0
    local.get 1
    local.get 2
    local.get 3
    call 0
    i32.const 1)
  (func (;20;) (type 2) (param i32 i32) (result i32)
    local.get 0
    i32.const 0
    i32.eq
    local.get 1
    call 5
    i32.and
    local.get 0
    i32.const 7
    i32.eq
    local.get 1
    call 6
    i32.and
    i32.or
    if (result i32)  ;; label = @1
      i32.const 1
    else
      i32.const 0
    end)
  (func (;21;) (type 1) (param i32 i32)
    (local i32)
    local.get 0
    local.get 1
    call 14
    local.set 2
    local.get 0
    local.get 1
    local.get 2
    call 7
    call 13
    local.get 0
    local.get 1
    call 1)
  (func (;22;) (type 2) (param i32 i32) (result i32)
    local.get 0
    local.get 1
    i32.sub)
  (func (;23;) (type 5)
    i32.const 1
    i32.const 0
    global.get 1
    call 13
    i32.const 3
    i32.const 0
    global.get 1
    call 13
    i32.const 5
    i32.const 0
    global.get 1
    call 13
    i32.const 7
    i32.const 0
    global.get 1
    call 13
    i32.const 0
    i32.const 1
    global.get 1
    call 13
    i32.const 2
    i32.const 1
    global.get 1
    call 13
    i32.const 4
    i32.const 1
    global.get 1
    call 13
    i32.const 6
    i32.const 1
    global.get 1
    call 13
    i32.const 1
    i32.const 2
    global.get 1
    call 13
    i32.const 3
    i32.const 2
    global.get 1
    call 13
    i32.const 5
    i32.const 2
    global.get 1
    call 13
    i32.const 7
    i32.const 2
    global.get 1
    call 13
    i32.const 0
    i32.const 5
    global.get 0
    call 13
    i32.const 2
    i32.const 5
    global.get 0
    call 13
    i32.const 4
    i32.const 5
    global.get 0
    call 13
    i32.const 6
    i32.const 5
    global.get 0
    call 13
    i32.const 1
    i32.const 6
    global.get 0
    call 13
    i32.const 3
    i32.const 6
    global.get 0
    call 13
    i32.const 5
    i32.const 6
    global.get 0
    call 13
    i32.const 7
    i32.const 6
    global.get 0
    call 13
    i32.const 0
    i32.const 7
    global.get 0
    call 13
    i32.const 2
    i32.const 7
    global.get 0
    call 13
    i32.const 4
    i32.const 7
    global.get 0
    call 13
    i32.const 6
    i32.const 7
    global.get 0
    call 13
    global.get 0
    call 11)
  (memory (;0;) 1)
  (global (;0;) i32 (i32.const 1))
  (global (;1;) i32 (i32.const 2))
  (global (;2;) i32 (i32.const 4))
  (global (;3;) (mut i32) (i32.const 0))
  (export "indexForPosition" (func 2))
  (export "offsetForPosition" (func 3))
  (export "isCrowned" (func 4))
  (export "isWhite" (func 5))
  (export "isBlack" (func 6))
  (export "withCrown" (func 7))
  (export "withoutCrown" (func 8))
  (export "getTurnOwner" (func 9))
  (export "toggleTurnOwner" (func 10))
  (export "setTurnOwner" (func 11))
  (export "isPlayersTurn" (func 12))
  (export "setPiece" (func 13))
  (export "getPiece" (func 14))
  (export "move" (func 18))
  (export "shouldCrown" (func 20))
  (export "crownPiece" (func 21))
  (export "distance" (func 22))
  (export "initBoard" (func 23))
  (export "memory" (memory 0)))
