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


# C
```
cd python/ctypes/hello_c/
gcc hello_world.c -o hello_world.o
python3 hello_world.py
```
```
Hello, World!
Answer =  42 <class 'int'>
```

# Rust
- DOCS: https://bheisler.github.io/post/calling-rust-in-python/
```
cd python/ctypes/hello_rust/
cargo build
python3 hello_rust_cffi.py
python3 hello_rust_ctypes.py
```

# GO
- DOCS: https://stackoverflow.com/questions/56586267/calling-go-from-python
```
cd python/ctypes/hello_go/
go build -o hello_go.so -buildmode=c-shared hello_go.go 
```

# D
- DOCS: https://pyd.readthedocs.io/en/latest/extend.html
- BUG: unable to compile with pyd
```
brew instal dmd dub
dub run pyd:setup

cd python/ctypes/hello_d/
dmd hello_d.d 

```