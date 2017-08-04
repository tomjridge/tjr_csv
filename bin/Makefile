SHELL:=bash

all: a.out test

a.out: FORCE
	ocamlfind ocamlopt -package tjr_csv,yojson,tjr_lib -linkpkg main.ml

test: FORCE
	ocamlfind ocamlopt -package p0,tjr_csv -linkpkg -o test test.ml
	./test

test2: FORCE
	cat test.csv | ./tjr_csv.sh --outsep \|

clean:
		rm -f *.{cmi,cmo,cmx,o,a,cmxa,cma} test a.out

FORCE:
