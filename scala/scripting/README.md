# Scala Scripting

Scala can be run as a scripting language

```
scala hello.scala planet
```

Or in conjunction with a shebang 
#!/usr/bin/env scala
```
chmod +x ./hello.scala
./hello.scala planet
```

But scripts with shebangs or outside classes fail to compile 
```
scalac ./hello.scala 
./hello.scala:1: error: expected class or object definition
#!/usr/bin/env scala
^
./hello.scala:6: error: expected class or object definition
val who = if (args.length >= 1) args(0) else "world"
^
./hello.scala:7: error: expected class or object definition
println("Hello, " + who + "!")
^
three errors found
```