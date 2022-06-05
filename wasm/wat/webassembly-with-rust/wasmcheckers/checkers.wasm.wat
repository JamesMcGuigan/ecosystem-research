(module
  (type (;0;) (func (param i32 i32) (result i32)))
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
  (memory (;0;) 1))
