(module
  (type (;0;) (func (result i32)))
  (type (;1;) (func (param i32) (result i32)))
  (type (;2;) (func (param i32 i32) (result i32)))
  (type (;3;) (func))
  (type (;4;) (func (param i32)))
  (func (;0;) (type 3)
    nop)
  (func (;1;) (type 0) (result i32)
    i32.const 42)
  (func (;2;) (type 1) (param i32) (result i32)
    local.get 0
    local.get 0
    i32.mul)
  (func (;3;) (type 2) (param i32 i32) (result i32)
    local.get 0
    local.get 1
    i32.add)
  (func (;4;) (type 2) (param i32 i32) (result i32)
    (local i32 i32)
    block  ;; label = @1
      local.get 1
      i32.const 0
      i32.le_s
      if  ;; label = @2
        br 1 (;@1;)
      end
      loop  ;; label = @2
        local.get 0
        local.get 3
        i32.const 2
        i32.shl
        i32.add
        i32.load
        local.get 2
        i32.add
        local.set 2
        local.get 3
        i32.const 1
        i32.add
        local.tee 3
        local.get 1
        i32.ne
        br_if 0 (;@2;)
      end
    end
    local.get 2)
  (func (;5;) (type 0) (result i32)
    global.get 0)
  (func (;6;) (type 4) (param i32)
    local.get 0
    global.set 0)
  (func (;7;) (type 1) (param i32) (result i32)
    global.get 0
    local.get 0
    i32.sub
    i32.const -16
    i32.and
    local.tee 0
    global.set 0
    local.get 0)
  (func (;8;) (type 0) (result i32)
    i32.const 1024)
  (table (;0;) 1 1 funcref)
  (memory (;0;) 256 256)
  (global (;0;) (mut i32) (i32.const 5243920))
  (export "memory" (memory 0))
  (export "__wasm_call_ctors" (func 0))
  (export "answer" (func 1))
  (export "squared" (func 2))
  (export "addTwoInts" (func 3))
  (export "sumArrayInt32" (func 4))
  (export "sumArrayInt64" (func 4))
  (export "__indirect_function_table" (table 0))
  (export "__errno_location" (func 8))
  (export "stackSave" (func 5))
  (export "stackRestore" (func 6))
  (export "stackAlloc" (func 7)))
