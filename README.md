# Trivial examples

This repository contains several trivial example which can be used as
fundament for actual projects. Below a short overview of each example.

## [Bytecode OS](bytecode-os)

An example on how to create the most basic kernel that processes
given bytecode. A bootloader is included, so it is bootable and can be
run as virtual machine.

## [D to Ruby FFI](d-to-ruby-ffi)

This example shows how to compile a shared library in the programming
language D and use it in arbitrary Ruby code.

## [Post mortem debugging](post-mortem-debugging)

C(++) code can crash due to an error. This example shows how to examine
the error after the crash occurred.

## [Black noise generator](black-noise-generator)
A project that plays black noise (silent audio).

## [Executable File Patching](executable-file-patching)
This demonstrates how one can compile an exectable and let the executable show
its own size without using File I/O. It is a technique where information gets
injected into the executable directly.

## [(Logical) lines of code](lloc.py)
This is a script that is just added for educational purposes.
One can see that (logical) lines of code can be counted using lexical tools.
In this case, we use Regex in combination with Python. Note that developing
such analysis tools should actually be avoided for actual usage. One can
develop tool to get better understanding of code quality, but should use
tools like Sonar to actually indicate the quality of code.
