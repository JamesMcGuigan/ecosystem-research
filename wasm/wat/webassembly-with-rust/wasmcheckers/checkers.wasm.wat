(module
  (type (;0;) (func (param i32 i32) (result i32)))
  (type (;1;) (func (param i32) (result i32)))
  (type (;2;) (func (param i32 i32 i32)))
  (type (;3;) (func (param i32 i32 i32) (result i32)))
  (func (;0;) (type 0) (param i32 i32) (result i32)
    i32.const 8
    local.get 1
    i32.mul
    local.get 0
    i32.add)
  (func (;1;) (type 0) (param i32 i32) (result i32)
    local.get 0
    local.get 1
    call 0
    i32.const 4
    i32.mul)
  (func (;2;) (type 1) (param i32) (result i32)
    local.get 0
    global.get 2
    i32.and
    global.get 2
    i32.eq)
  (func (;3;) (type 1) (param i32) (result i32)
    local.get 0
    global.get 1
    i32.and
    global.get 1
    i32.eq)
  (func (;4;) (type 1) (param i32) (result i32)
    local.get 0
    global.get 0
    i32.and
    global.get 0
    i32.eq)
  (func (;5;) (type 1) (param i32) (result i32)
    local.get 0
    global.get 2
    i32.or)
  (func (;6;) (type 1) (param i32) (result i32)
    local.get 0
    global.get 2
    i32.and)
  (func (;7;) (type 2) (param i32 i32 i32)
    local.get 0
    local.get 1
    call 1
    local.get 2
    i32.store)
  (func (;8;) (type 0) (param i32 i32) (result i32)
    block (result i32)  ;; label = @1
      i32.const 0
      i32.const 7
      local.get 0
      call 9
      i32.const 0
      i32.const 7
      local.get 1
      call 9
      i32.and
    end
    if (result i32)  ;; label = @1
      local.get 0
      local.get 1
      call 1
      i32.load
    else
      unreachable
    end)
  (func (;9;) (type 3) (param i32 i32 i32) (result i32)
    local.get 2
    local.get 0
    i32.ge_s
    local.get 2
    local.get 1
    i32.le_s
    i32.and)
  (memory (;0;) 1)
  (global (;0;) i32 (i32.const 1))
  (global (;1;) i32 (i32.const 2))
  (global (;2;) i32 (i32.const 4))
  (export "indexForPosition" (func 0))
  (export "offsetForPosition" (func 1))
  (export "isCrowned" (func 2))
  (export "isWhite" (func 3))
  (export "isBlack" (func 4))
  (export "withCrown" (func 5))
  (export "withoutCrown" (func 6))
  (export "setPiece" (func 7))
  (export "getPiece" (func 8)))
