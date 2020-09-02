# DOCS: https://bheisler.github.io/post/calling-rust-in-python/

from cffi import FFI
ffi = FFI()
ffi.cdef("""
    int times2(int);
""")
rust = ffi.dlopen("./target/debug/libhello_rust.dylib")

print('C.times2(9)', rust.times2(9))