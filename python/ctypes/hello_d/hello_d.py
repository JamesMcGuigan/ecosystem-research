#!/usr/bin/env python3

from ctypes import *

c4lib = cdll.LoadLibrary("hello_d.o")
answer = c4lib.hello_world()
print('Answer = ', answer, type(answer))