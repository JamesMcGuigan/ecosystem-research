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
C is the classic systems programming language
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

Rust is the new cool kid on the block, with C like performance, 
modern language features, a statically compiled GC and memory safety.
```
cd python/ctypes/hello_rust/
cargo build
python3 hello_rust_cffi.py
python3 hello_rust_ctypes.py
```

# GO
- DOCS: https://stackoverflow.com/questions/56586267/calling-go-from-python

Go is a minimalist language that is almost (but not quite) as fast a C during runtime,
and can be statically compiled, with a runtime GC. Source code can also be directly run
via the go interpreter without needing to compile to a binary.

Syntax has a C/Java/Javascript feel to it, and it has been suggested that it may be 
productive in terms of developer time than programming in Rust as it less strict about 
statically compiled guarantees. 

It has concurrency safety/support built into the language and shines in multithreaded applications.
The fastest webserver in the world is written in GO.

```
cd python/ctypes/hello_go/
go build -o hello_go.so -buildmode=c-shared hello_go.go 
```

# NIM
- Source: https://github.com/octonion/puzzles/tree/master/blackjack/python-nim

Nim is a new language with Python like syntax that compiles to C, C++ or JavaScript.

NOTE: ctypes requires manually casting to c_long, whereas cffi doesn't (but requires a type signiture)

```
sudo apt install nim
```
```
nim c   -d:release --opt:speed --app:lib hello_nim.nim
nim cpp -d:release --opt:speed --app:lib hello_nim.nim
nim js  -d:release --opt:speed --app:lib hello_nim.nim

python3 hello_nim_ctypes.py 
python3 hello_nim_cffi.py 
```

```
Dealer showing  0  partitions = 417334
Dealer showing  1  partitions = 560954
Dealer showing  2  partitions = 658854
Dealer showing  3  partitions = 679464
Dealer showing  4  partitions = 680299
Dealer showing  5  partitions = 680305
Dealer showing  6  partitions = 680305
Dealer showing  7  partitions = 680305
Dealer showing  8  partitions = 680305
Dealer showing  9  partitions = 680305
Total partitions = 6398430
```
 
# D
- DOCS: https://pyd.readthedocs.io/en/latest/extend.html
- BUG: unable to compile with pyd

D is a variant C with support for modern idoms borrowed from scripting languages.

```
sudo snap install dmd --classic
sudo snap install dub --classic
brew instal dmd dub
cd python/ctypes/hello_d/
```
```
dub run pyd:setup
dmd hello_d.d 
```
```
$ dmd hello_d.d 
hello_d.d(5): Error: module pyd is in file 'pyd/pyd.d' which cannot be read
import path[0] = /snap/dmd/102/bin/../import/druntime
import path[1] = /snap/dmd/102/bin/../import/phobos
```