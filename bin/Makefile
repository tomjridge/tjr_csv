SHELL:=bash

NATIVE:=tjr_csv.native

all: $(NATIVE) test

$(NATIVE): FORCE
	ocamlfind ocamlopt -thread -package tjr_csv,yojson,tjr_lib -linkpkg -o $(NATIVE) main.ml

test: FORCE
	ocamlfind ocamlopt -package p0,tjr_csv -linkpkg -o test test.ml
	./test

test2: FORCE
	cat test.csv | ./tjr_csv.sh --outsep \|

install:
	cp tjr_csv.{sh,native} /tmp

clean:
		rm -f *.{cmi,cmo,cmx,o,a,cmxa,cma} test $(NATIVE)

FORCE:
