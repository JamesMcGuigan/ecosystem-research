// DOCS: https://rob-blackbourn.github.io/blog/webassembly/wasm/array/arrays/javascript/c/2020/06/07/wasm-arrays.html
// #define EMSCRIPTEN_KEEPALIVE attribute((used)) | prevents -O3 from code pruning exports | https://github.com/emscripten-core/emscripten/issues/6546
#include <emscripten.h>

int EMSCRIPTEN_KEEPALIVE answer() {
   return 42;
}

int EMSCRIPTEN_KEEPALIVE squared(int x) {
   return x * x;
}

__attribute__((used)) int addTwoInts (int a, int b) {
    return a + b;
}

EMSCRIPTEN_KEEPALIVE
int sumArrayInt32 (int *array, int length) {
    int total = 0;
    for (int i = 0; i < length; ++i) {
        total += array[i];
    }
    return total;
}

EMSCRIPTEN_KEEPALIVE
long sumArrayInt64 (long *array, int length) {
    long total = 0;
    for (int i = 0; i < length; ++i) {
        total += array[i];
    }
    return total;
}