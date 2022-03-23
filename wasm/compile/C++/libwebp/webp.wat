(module
  (type (;0;) (func (result i32)))
  (type (;1;) (func (param i32) (result i32)))
  (type (;2;) (func (param i32 i64 i32) (result i64)))
  (type (;3;) (func (param i32)))
  (type (;4;) (func))
  (type (;5;) (func (param i32 i32 i32) (result i32)))
  (type (;6;) (func (param i32 i32 i32 i32 i32) (result i32)))
  (type (;7;) (func (param i32 i32 i32 i32) (result i32)))
  (type (;8;) (func (param i32 i32 i64 i32) (result i64)))
  (type (;9;) (func (param i32 i64 i32 i32) (result i32)))
  (import "wasi_snapshot_preview1" "fd_close" (func (;0;) (type 1)))
  (import "wasi_snapshot_preview1" "fd_write" (func (;1;) (type 7)))
  (import "env" "setTempRet0" (func (;2;) (type 3)))
  (import "wasi_snapshot_preview1" "fd_seek" (func (;3;) (type 6)))
  (func (;4;) (type 4)
    call 22)
  (func (;5;) (type 0) (result i32)
    (local i32)
    call 6
    local.set 0
    local.get 0
    return)
  (func (;6;) (type 0) (result i32)
    (local i32)
    i32.const 66050
    local.set 0
    local.get 0
    return)
  (func (;7;) (type 1) (param i32) (result i32)
    local.get 0)
  (func (;8;) (type 1) (param i32) (result i32)
    local.get 0
    i32.load offset=60
    call 7
    call 0)
  (func (;9;) (type 5) (param i32 i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32)
    global.get 0
    i32.const 32
    i32.sub
    local.tee 3
    global.set 0
    local.get 3
    local.get 0
    i32.load offset=28
    local.tee 4
    i32.store offset=16
    local.get 0
    i32.load offset=20
    local.set 5
    local.get 3
    local.get 2
    i32.store offset=28
    local.get 3
    local.get 1
    i32.store offset=24
    local.get 3
    local.get 5
    local.get 4
    i32.sub
    local.tee 1
    i32.store offset=20
    local.get 1
    local.get 2
    i32.add
    local.set 6
    i32.const 2
    local.set 7
    local.get 3
    i32.const 16
    i32.add
    local.set 1
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            local.get 0
            i32.load offset=60
            local.get 3
            i32.const 16
            i32.add
            i32.const 2
            local.get 3
            i32.const 12
            i32.add
            call 1
            call 18
            br_if 0 (;@4;)
            loop  ;; label = @5
              local.get 6
              local.get 3
              i32.load offset=12
              local.tee 4
              i32.eq
              br_if 2 (;@3;)
              local.get 4
              i32.const -1
              i32.le_s
              br_if 3 (;@2;)
              local.get 1
              local.get 4
              local.get 1
              i32.load offset=4
              local.tee 8
              i32.gt_u
              local.tee 5
              i32.const 3
              i32.shl
              i32.add
              local.tee 9
              local.get 9
              i32.load
              local.get 4
              local.get 8
              i32.const 0
              local.get 5
              select
              i32.sub
              local.tee 8
              i32.add
              i32.store
              local.get 1
              i32.const 12
              i32.const 4
              local.get 5
              select
              i32.add
              local.tee 9
              local.get 9
              i32.load
              local.get 8
              i32.sub
              i32.store
              local.get 6
              local.get 4
              i32.sub
              local.set 6
              local.get 0
              i32.load offset=60
              local.get 1
              i32.const 8
              i32.add
              local.get 1
              local.get 5
              select
              local.tee 1
              local.get 7
              local.get 5
              i32.sub
              local.tee 7
              local.get 3
              i32.const 12
              i32.add
              call 1
              call 18
              i32.eqz
              br_if 0 (;@5;)
            end
          end
          local.get 6
          i32.const -1
          i32.ne
          br_if 1 (;@2;)
        end
        local.get 0
        local.get 0
        i32.load offset=44
        local.tee 1
        i32.store offset=28
        local.get 0
        local.get 1
        i32.store offset=20
        local.get 0
        local.get 1
        local.get 0
        i32.load offset=48
        i32.add
        i32.store offset=16
        local.get 2
        local.set 4
        br 1 (;@1;)
      end
      i32.const 0
      local.set 4
      local.get 0
      i32.const 0
      i32.store offset=28
      local.get 0
      i64.const 0
      i64.store offset=16
      local.get 0
      local.get 0
      i32.load
      i32.const 32
      i32.or
      i32.store
      local.get 7
      i32.const 2
      i32.eq
      br_if 0 (;@1;)
      local.get 2
      local.get 1
      i32.load offset=4
      i32.sub
      local.set 4
    end
    local.get 3
    i32.const 32
    i32.add
    global.set 0
    local.get 4)
  (func (;10;) (type 2) (param i32 i64 i32) (result i64)
    (local i32)
    global.get 0
    i32.const 16
    i32.sub
    local.tee 3
    global.set 0
    local.get 0
    local.get 1
    local.get 2
    i32.const 255
    i32.and
    local.get 3
    i32.const 8
    i32.add
    call 28
    call 18
    local.set 0
    local.get 3
    i64.load offset=8
    local.set 1
    local.get 3
    i32.const 16
    i32.add
    global.set 0
    i64.const -1
    local.get 1
    local.get 0
    select)
  (func (;11;) (type 2) (param i32 i64 i32) (result i64)
    local.get 0
    i32.load offset=60
    local.get 1
    local.get 2
    call 10)
  (func (;12;) (type 1) (param i32) (result i32)
    i32.const 1)
  (func (;13;) (type 3) (param i32))
  (func (;14;) (type 0) (result i32)
    i32.const 1180
    call 13
    i32.const 1184)
  (func (;15;) (type 4)
    (local i32)
    block  ;; label = @1
      call 14
      i32.load
      local.tee 0
      i32.eqz
      br_if 0 (;@1;)
      loop  ;; label = @2
        local.get 0
        call 16
        local.get 0
        i32.load offset=56
        local.tee 0
        br_if 0 (;@2;)
      end
    end
    i32.const 0
    i32.load offset=1188
    call 16
    i32.const 0
    i32.load offset=1188
    call 16
    i32.const 0
    i32.load offset=1168
    call 16)
  (func (;16;) (type 3) (param i32)
    (local i32 i32)
    block  ;; label = @1
      local.get 0
      i32.eqz
      br_if 0 (;@1;)
      block  ;; label = @2
        local.get 0
        i32.load offset=76
        i32.const 0
        i32.lt_s
        br_if 0 (;@2;)
        local.get 0
        call 12
        drop
      end
      block  ;; label = @2
        local.get 0
        i32.load offset=20
        local.get 0
        i32.load offset=28
        i32.eq
        br_if 0 (;@2;)
        local.get 0
        i32.const 0
        i32.const 0
        local.get 0
        i32.load offset=36
        call_indirect (type 5)
        drop
      end
      local.get 0
      i32.load offset=4
      local.tee 1
      local.get 0
      i32.load offset=8
      local.tee 2
      i32.eq
      br_if 0 (;@1;)
      local.get 0
      local.get 1
      local.get 2
      i32.sub
      i64.extend_i32_s
      i32.const 1
      local.get 0
      i32.load offset=40
      call_indirect (type 2)
      drop
    end)
  (func (;17;) (type 0) (result i32)
    i32.const 1192)
  (func (;18;) (type 1) (param i32) (result i32)
    block  ;; label = @1
      local.get 0
      br_if 0 (;@1;)
      i32.const 0
      return
    end
    call 17
    local.get 0
    i32.store
    i32.const -1)
  (func (;19;) (type 0) (result i32)
    global.get 0)
  (func (;20;) (type 3) (param i32)
    local.get 0
    global.set 0)
  (func (;21;) (type 1) (param i32) (result i32)
    (local i32 i32)
    global.get 0
    local.get 0
    i32.sub
    i32.const -16
    i32.and
    local.tee 1
    global.set 0
    local.get 1)
  (func (;22;) (type 4)
    i32.const 5244080
    global.set 2
    i32.const 1196
    i32.const 15
    i32.add
    i32.const -16
    i32.and
    global.set 1)
  (func (;23;) (type 0) (result i32)
    global.get 0
    global.get 1
    i32.sub)
  (func (;24;) (type 0) (result i32)
    global.get 2)
  (func (;25;) (type 0) (result i32)
    global.get 1)
  (func (;26;) (type 8) (param i32 i32 i64 i32) (result i64)
    local.get 1
    local.get 2
    local.get 3
    local.get 0
    call_indirect (type 2))
  (func (;27;) (type 6) (param i32 i32 i32 i32 i32) (result i32)
    (local i64)
    local.get 0
    local.get 1
    local.get 2
    i64.extend_i32_u
    local.get 3
    i64.extend_i32_u
    i64.const 32
    i64.shl
    i64.or
    local.get 4
    call 26
    local.set 5
    local.get 5
    i64.const 32
    i64.shr_u
    i32.wrap_i64
    call 2
    local.get 5
    i32.wrap_i64)
  (func (;28;) (type 9) (param i32 i64 i32 i32) (result i32)
    local.get 0
    local.get 1
    i32.wrap_i64
    local.get 1
    i64.const 32
    i64.shr_u
    i32.wrap_i64
    local.get 2
    local.get 3
    call 3)
  (table (;0;) 4 4 funcref)
  (memory (;0;) 256 256)
  (global (;0;) (mut i32) (i32.const 5244080))
  (global (;1;) (mut i32) (i32.const 0))
  (global (;2;) (mut i32) (i32.const 0))
  (export "memory" (memory 0))
  (export "__wasm_call_ctors" (func 4))
  (export "version" (func 5))
  (export "__indirect_function_table" (table 0))
  (export "__errno_location" (func 17))
  (export "__stdio_exit" (func 15))
  (export "emscripten_stack_init" (func 22))
  (export "emscripten_stack_get_free" (func 23))
  (export "emscripten_stack_get_base" (func 24))
  (export "emscripten_stack_get_end" (func 25))
  (export "stackSave" (func 19))
  (export "stackRestore" (func 20))
  (export "stackAlloc" (func 21))
  (export "dynCall_jiji" (func 27))
  (elem (;0;) (i32.const 1) func 8 9 11)
  (data (;0;) (i32.const 1024) "\05\00\00\00\00\00\00\00\00\00\00\00\01\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\03\00\00\00\9c\04\00\00\00\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\ff\ff\ff\ff\ff\ff\ff\ff\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\04\00\00"))
