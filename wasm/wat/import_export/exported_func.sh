#!/bin/bash
cd $(readlink -f $(dirname $BASH_SOURCE[0]));  # cd current directory
set -x

wat2wasm exported_func.wat -o exported_func.wasm  # compile
