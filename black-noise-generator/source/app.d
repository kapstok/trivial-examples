import std.stdio;
import std.process;

void main() {
    writeln("You do hear black noise as long as this application and aplay is running.");

    auto shell = executeShell("aplay -fdat /dev/zero");
}
