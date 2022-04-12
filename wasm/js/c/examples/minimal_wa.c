// Source: https://compile.fi/canvas-filled-three-ways-js-webassembly-and-webgl/
// #define EMSCRIPTEN_KEEPALIVE attribute((used))  // https://github.com/emscripten-core/emscripten/issues/6546

#include <emscripten.h>
//#define HEIGHT 25
//#define WIDTH  25

//int data[WIDTH * HEIGHT];
//int red = (255 << 24) | 255;

int EMSCRIPTEN_KEEPALIVE answer() {
   return 42;
}

int EMSCRIPTEN_KEEPALIVE squared(int x) {
   return x * x;
}

// Source: https://rob-blackbourn.github.io/blog/webassembly/wasm/array/arrays/javascript/c/2020/06/07/wasm-arrays.html
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

//// Source: https://compile.fi/canvas-filled-three-ways-js-webassembly-and-webgl/
//int* EMSCRIPTEN_KEEPALIVE render() {
//   for (int y = 0; y < HEIGHT; y++) {
//     int yw = y * WIDTH;
//     for (int x = 0; x < WIDTH; x++) {
//       data[yw + x] = yw + x;
//     }
//   }
//   return &data[0];
//}
//
