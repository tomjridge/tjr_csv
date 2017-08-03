SHELL:=bash

libname:=tjr_csv
xxx:=$(libname)
pkg:=-package p0

all:
	ocamlfind ocamlc $(pkg) -c $(xxx).ml
	ocamlfind ocamlopt $(pkg) -c $(xxx).ml
	ocamlfind ocamlc -g -a -o $(libname).cma $(xxx).cmo
	ocamlfind ocamlopt -g -a -o $(libname).cmxa $(xxx).cmx
	-ocamlfind remove $(libname)
	ocamlfind install $(libname) META *.cmi *.o *.a *.cma *.cmxa *.cmo *.cmx 

clean:
	rm -f *.{cmi,cmo,cmx,o,a,cmxa,cma}
	$(MAKE) -C bin clean

