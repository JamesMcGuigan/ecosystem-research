from ctypes import *

rust   = cdll.LoadLibrary("./target/debug/libhello_rust.dylib")
answer = rust.times2(64)
print('rust.times2(64)', rust.times2(64))
