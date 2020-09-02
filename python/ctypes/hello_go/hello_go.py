# DOCS: https://stackoverflow.com/questions/56586267/calling-go-from-python
from ctypes import *

# loading shared object
lib = cdll.LoadLibrary("./hello_go.so")


# go type
class GoSlice(Structure):
    _fields_ = [("data", POINTER(c_void_p)), ("len", c_longlong), ("cap", c_longlong)]


class Foo(Structure):
    _fields_ = [('a', c_int),
                ('b', c_int),
                ('c', c_int),
                ('d', c_int),
                ('e', c_int),
                ('f', c_int)]


lib.Foo.argtypes = [GoSlice]
lib.Foo.restype = Foo

t = GoSlice((c_void_p * 5)(1, 2, 3, 4, 5), 5, 5)
f = lib.Foo(t)
print(f)
print(f.a)
print(f.b)