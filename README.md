# Fault handling

When the application crashes, e.g. due to derefencing `NULL`, a dump will be made.
The dump will be shown on the Terminal and will saved in a log file called `/var/log/messages`.

## Compiling

> Commands executed from repository's root.

```
g++ main.c -o exe
g++ main.c -g -o dbgexe
```

## Post mortem debugging

Running `./exe` results in this output:

```
Error 11 at (nil):
Called from 0x400a48
Compiled at: May 30 2018 09:24:41
Aborted (geheugendump gemaakt)
```

In order to read the dump from the log file, while filtering all log info from other applications, one should execute the following command in a Terminal:

```
# cat /var/log/messages | grep "postmortem-debugging" | sed 's/#012/\n\t/g' | less
```

> Syslog turns newlines ('\n') in '#012'. The sed command reverts that.

Possible output would be:

```
May 30 09:38:14 localhost postmortem-debugging[14671]: Error 11 at (nil):
May 30 09:38:14 localhost postmortem-debugging[14671]: Called from 0x400a48.
May 30 09:38:14 localhost postmortem-debugging[14671]: Compiled at: May 30 2018 09:24:41
```

Let's see what caused the error by executing this one-liner:

```
$ gdb ./dbgexe
```

Then you need to use the information from the log file. Execute this code in `gdb`:

```
l *0x400a48
```

> Use the output from running ./exe ('Called from 0x400a48').

As `gdb` states, the error was caused at line 71:

```
0x400a48 is in main() (main.cpp:71).
```
