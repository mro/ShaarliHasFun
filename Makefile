#
# https://github.com/ocaml/dune/tree/master/example/sample-projects/hello_world
# via https://stackoverflow.com/a/54712669
#
.PHONY: all build clean test install uninstall doc examples

build:
	dune build bin/shaarli_cgi.exe

all: build

test:
	dune runtest

examples:
	dune build @examples

install:
	dune install

uninstall:
	dune uninstall

doc:
	dune build @doc

clean:
	rm -rf _build *.install

