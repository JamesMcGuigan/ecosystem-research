// DOCS: https://stackoverflow.com/questions/56586267/calling-go-from-python

package main

import (
	/*
	   typedef struct foo{
	   int a;
	   int b;
	   int c;
	   int d;
	   int e;
	   int f;
	   } foo;
	*/
	"C"
)

func main() {
}

//export Foo
func Foo(t []int) C.foo {
	foo := C.foo{}
	foo.a = 1 // setting some values to avoid seeing zeros
	foo.b = 2
	return foo
}
