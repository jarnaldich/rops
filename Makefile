# Makefile for ROP scheme.
#
# TODO: Add rules for generating a native-code interpreter.
#

CAMLBIN=/usr/local/bin/
CAMLC = $(CAMLBIN)ocamlc -I +camlp4 dynlink.cma camlp4lib.cma -pp camlp4of.opt
CAMLOPT = $(CAMLBIN)ocamlopt  -I +camlp4 dynlink.cma camlp4lib.cma -pp camlp4of.opt
MKTOP = $(CAMLBIN)ocamlmktop -I +camlp4 dynlink.cma camlp4lib.cma -pp camlp4of.opt
EXEC = rops

.SUFFIXES: .ml .mli .cmo .cmi .cmx

.ml.cmo:
	$(CAMLC) -c $<

.mli.cmi:
	$(CAMLC) -c $<

$(EXEC): utils.cmo  schemeTypes.cmo reader.cmi builtins.cmi builtins.cmo reader.cmo printer.cmo repl.cmo 
	$(CAMLC) -o $(EXEC) $(filter %.cmo, $^)

console: utils.cmo printer.cmo reader.cmo
	$(MKTOP) $^ -o console

all: $(EXEC)

clean::
	rm -f *.cm[iox] *~ .*~ #*#
	rm -f $(EXEC)
	rm -f schemeTypes.mli
	rm -f console
	rm -f $(EXEC).opt
