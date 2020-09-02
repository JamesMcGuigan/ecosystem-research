#!/usr/bin/env python3

from ctypes import *

c4lib = cdll.LoadLibrary("hello_world.o")
answer = c4lib.hello_world("Morning")
print('Answer = ', answer, type(answer))