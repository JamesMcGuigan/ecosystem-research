#!/usr/bin/env scala
// $ ./hello.scala planet
// $ scala hello.scala planet

// Say hello to the first argument
val who = if (args.length >= 1) args(0) else "world"
println("Hello, " + who + "!")