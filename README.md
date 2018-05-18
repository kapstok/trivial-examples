# Fault handling

## Compiling

> Commands executed from repository's root.

```
g++ main.cpp -o exe
g++ main.cpp -g -o dbgexe
```

## Post mortem debugging

Running `./exe` results in this output:

```
Fout 11 at 0: 
Called from 4197438.
Aborted (geheugendump gemaakt)
```

See what caused the error:

> Use the output from running ./exe ('Called from 4197438').

```
gdb ./dbgexe
l *4197438
```

As `gdb` states, the error was caused at line 57:

```
0x400c3e is in main() (main.cpp:57).
```
