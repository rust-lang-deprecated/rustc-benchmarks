all:
	rustc -Ztime-passes src/lib.rs --crate-type rlib -o libregex.rlib --crate-name regex
	rustc -Ztime-passes regex_macros/src/lib.rs --crate-type rlib -L . -o regex_macros.rlib
clean:
	rm *.rlib
