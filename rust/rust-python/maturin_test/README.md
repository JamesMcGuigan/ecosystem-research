# Python Rust Module with maturin
- DOCS: https://github.com/PyO3/maturin
- EXAMPLE: https://github.com/deepgreenAN/pyo3_error_handling

Install
```
pip install cffi maturin 
maturin new maturin_test  # cffi bindings are more compatable
maturin build             # build into ./target/wheels/
maturin develop           # build + install in local venv
maturin publish           # publish to pypi 
```

Buildchain
```
cargo check               # WORKS 
cargo build               # ERROR: linker failure
poetry install            # reads pyproject.toml
poetry run maturin develop
poetry run maturin build --release
```

Usage
```
$ source  ./python/venv/bin/activate
$ python3 ./python/main.py

import maturin_test
maturin_test.double(42)     = 84
maturin_test.double_f64(42) = 84.0
```