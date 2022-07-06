# Python Rust Module with maturin
- DOCS: https://github.com/PyO3/maturin

maturin
```
pip install cffi maturin 
maturin new maturin  # cffi bindings are more compatable
maturin build        # build into ./target/wheels/
maturin develop      # build + install in local venv
maturin publish      # publish to pypi 
```