entry:
	clang -dynamiclib -std=c99 entry.c -o libentry.A.dylib
	julia entry.jl

clean:
	rm -f libentry.A.dylib
