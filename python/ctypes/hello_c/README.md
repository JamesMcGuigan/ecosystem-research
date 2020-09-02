# Hello World via Python Ctypes

The goal of this experiment is to call a C compiled function from Python

# Question

> How do get C code to run inside a Kaggle Kernel? 
```
from ctypes import *
c4lib = cdll.LoadLibrary("c4.so")
c4lib.yourCfunctionhere(…)
```
> How did you manage to get this like to run before multi-file submissions? Did you base64 encode c4.so?
>
> Yes, base64 encode it, and the write it out to a temporary file via tempfile.NamedTemporaryFile. (LoadLibrary does not seem to allow reading from memory).
- Peter Cnudde - https://www.kaggle.com/c/connectx/discussion/179022


# Instructions

```
cd python/ctypes/hello_c/
gcc hello_world.c -o hello_world.o
python3 hello_world.py
```
```
Hello, World!
Answer =  42 <class 'int'>
```
