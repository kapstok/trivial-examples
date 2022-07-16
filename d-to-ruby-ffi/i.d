import std.stdio;
import std.conv;

extern(C)
void hello(const char* name)
{
	// remember, it is a C function, so use C string
	// and convert inside
	writeln("hi from D, ", to!string(name));
}
