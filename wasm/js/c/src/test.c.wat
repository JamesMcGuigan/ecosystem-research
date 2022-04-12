(module
  (type (;0;) (func (result i32)))
  (type (;1;) (func (param i32 i32) (result i32)))
  (type (;2;) (func (param i32) (result i32)))
  (type (;3;) (func))
  (type (;4;) (func (param i32)))
  (func (;0;) (type 3)
    nop)
  (func (;1;) (type 0) (result i32)
    i32.const 42)
  (func (;2;) (type 2) (param i32) (result i32)
    local.get 0
    local.get 0
    i32.mul)
  (func (;3;) (type 1) (param i32 i32) (result i32)
    local.get 0
    local.get 1
    i32.add)
  (func (;4;) (type 1) (param i32 i32) (result i32)
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
  (func (;5;) (type 1) (param i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 f32 f32 f32)
    local.get 1
    i32.const 0
    i32.gt_s
    if  ;; label = @1
      local.get 0
      f32.convert_i32_s
      local.set 8
      local.get 1
      f32.convert_i32_s
      local.set 9
      local.get 0
      i32.const 0
      i32.le_s
      local.set 4
      loop  ;; label = @2
        local.get 4
        i32.eqz
        if  ;; label = @3
          local.get 0
          local.get 2
          i32.mul
          local.set 5
          block (result i32)  ;; label = @4
            local.get 2
            f32.convert_i32_s
            f32.const 0x1.fep+7 (;=255;)
            f32.mul
            local.get 9
            f32.div
            local.tee 7
            f32.abs
            f32.const 0x1p+31 (;=2.14748e+09;)
            f32.lt
            if  ;; label = @5
              local.get 7
              i32.trunc_f32_s
              br 1 (;@4;)
            end
            i32.const -2147483648
          end
          local.set 6
          i32.const 0
          local.set 3
          loop  ;; label = @4
            local.get 3
            local.get 5
            i32.add
            i32.const 2
            i32.shl
            i32.const 1024
            i32.add
            block (result i32)  ;; label = @5
              local.get 3
              f32.convert_i32_s
              f32.const 0x1.fep+7 (;=255;)
              f32.mul
              local.get 8
              f32.div
              local.tee 7
              f32.abs
              f32.const 0x1p+31 (;=2.14748e+09;)
              f32.lt
              if  ;; label = @6
                local.get 7
                i32.trunc_f32_s
                br 1 (;@5;)
              end
              i32.const -2147483648
            end
            i32.const 16
            i32.shl
            local.get 6
            i32.or
            i32.const -16777216
            i32.or
            i32.store
            local.get 3
            i32.const 1
            i32.add
            local.tee 3
            local.get 0
            i32.ne
            br_if 0 (;@4;)
          end
        end
        local.get 2
        i32.const 1
        i32.add
        local.tee 2
        local.get 1
        i32.ne
        br_if 0 (;@2;)
      end
    end
    i32.const 1024)
  (func (;6;) (type 0) (result i32)
    global.get 0)
  (func (;7;) (type 4) (param i32)
    local.get 0
    global.set 0)
  (func (;8;) (type 2) (param i32) (result i32)
    global.get 0
    local.get 0
    i32.sub
    i32.const -16
    i32.and
    local.tee 0
    global.set 0
    local.get 0)
  (func (;9;) (type 0) (result i32)
    i32.const 8295424)
  (table (;0;) 1 1 funcref)
  (memory (;0;) 256 256)
  (global (;0;) (mut i32) (i32.const 13538320))
  (export "memory" (memory 0))
  (export "__wasm_call_ctors" (func 0))
  (export "answer" (func 1))
  (export "squared" (func 2))
  (export "addTwoInts" (func 3))
  (export "sumArrayInt32" (func 4))
  (export "sumArrayInt64" (func 4))
  (export "renderCanvas" (func 5))
  (export "__indirect_function_table" (table 0))
  (export "__errno_location" (func 9))
  (export "stackSave" (func 6))
  (export "stackRestore" (func 7))
  (export "stackAlloc" (func 8)))
