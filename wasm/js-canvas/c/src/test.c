// DOCS: https://rob-blackbourn.github.io/blog/webassembly/wasm/array/arrays/javascript/c/2020/06/07/wasm-arrays.html
// #define EMSCRIPTEN_KEEPALIVE attribute((used)) | prevents -O3 from code pruning exports | https://github.com/emscripten-core/emscripten/issues/6546
#include <emscripten.h>

/** Simple Functions **/

int EMSCRIPTEN_KEEPALIVE answer() {
   return 42;
}

int EMSCRIPTEN_KEEPALIVE squared(int x) {
   return x * x;
}

__attribute__((used)) int addTwoInts (int a, int b) {
    return a + b;
}


/** Array Functions **/

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


/** Canvas Functions **/

// NOTE: This defines the amount of memory that gets preallocated,
//       but everything still seems to work if the screen is larger than the buffer
//       unsure if that results in any risk of buffer overflow ???
#define MAX_HEIGHT 1920
#define MAX_WIDTH  1080
int canvas_buffer[MAX_HEIGHT * MAX_WIDTH];  // test.c.wat: (func (;9;) (type 0) (result i32) i32.const 8295424) | (global (;0;) (mut i32) (i32.const 13538320))
// int canvas_buffer[256];                  // test.c.wat: (func (;9;) (type 0) (result i32) i32.const 2048)    | (global (;0;) (mut i32) (i32.const 5244944))

int RED   = 0xFF0000FF;  // alpha = 255 | blue = 0   | green = 0   | red = 255
int GREEN = 0xFF00FF00;  // alpha = 255 | blue = 0   | green = 255 | red = 0
int BLUE  = 0xFFFF0000;  // alpha = 255 | blue = 255 | green = 0   | red = 0
int rbga(int r, int b, int g, int a) {
    int color = (a << 24) | (b << 16) | (g << 8) | (r << 0);
    return color;
}

EMSCRIPTEN_KEEPALIVE
int* renderCanvas (int width, int height) {
    for (int y = 0; y < height; y++) {
        int yw = y * width;
        for (int x = 0; x < width; x++) {
            int r = 255.0f * y / height;
            int b = 255.0f * x / width;
            int g = 0;
            int a = 255;
            int color = rbga(r,b,g,a);
            // int color = GREEN;
            // int color = (a << 24) | (b << 16) | (g << 8) | (r << 0);
            canvas_buffer[yw + x] = color;
        }
    }
    return &canvas_buffer[0];  // return pointer
}

