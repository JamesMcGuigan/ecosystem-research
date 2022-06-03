# GCD Greatest Common Denominator in WAT

Source: https://docs.wasmtime.dev/lang-bash.html

Compile
```
wat2wasm gcd.wat 
```

Run
```
wasmtime gcd.wasm --invoke gcd 4 2  # BROKEN
node gcd.js 25 5                    # GCD of 25 and 5 is 5
```