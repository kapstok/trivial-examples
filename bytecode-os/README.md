# Bytecode OS

This Readme is separated in two parts:

* The Bytecode part, which shows how to write a binary file and parse it with
an executable.

* The OS part, which shows how to create a bare-bone OS that uses the Bytecode
part.

If you consider the bare-bone OS as an actual OS, then you could say that the
executable from the bytecode part is basically a virtual machine.

## The bytecode part

### Building

<placeholder>

### Bytecode reference

`prog.dat` is an example (binary) file that can be read by the executable.
The reference of the bytecode can be found below:

```
#!Virtual Machine

VM bytecode       prog bytecode   description 

1064              6410            1 - loadi, 0 - arg0 (register), 64 - value
11c8              c811            1 - loadi, 1 - arg0 (register), c8 - value
2201              0122            2 - add, 2 - arg0 (result register), 0 - arg1 (register 1), 1 - arg2 (register 2) 
0000              0000            0000 - halt
```

## The OS part

### Building

<placeholder>
