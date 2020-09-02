#include <stdio.h>


int hello_world(char* name) {
    printf("Hello, World!\n");
    return 42;
}

int main() {
    hello_world("main");
    return 0;
}