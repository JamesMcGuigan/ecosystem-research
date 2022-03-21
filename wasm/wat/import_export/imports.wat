(module
  (func (export "imported_func") (param i32)
    i32.const 42
    call $i
  )
)