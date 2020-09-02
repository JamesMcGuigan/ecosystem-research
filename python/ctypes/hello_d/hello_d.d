// DOCS: https://pyd.readthedocs.io/en/latest/extend.html
// A minimal "hello world" Pyd module.
module hello;

import pyd.pyd;
import std.stdio;

int hello_world() {
    writefln("Hello, world!");
    return 42;
}

extern(C) void PydMain() {
    def!(hello_world)();
    module_init();
}