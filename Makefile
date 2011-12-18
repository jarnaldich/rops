CAMLBIN=/usr/local/bin/
CAMLC = $(CAMLBIN)ocamlc -I +camlp4 dynlink.cma camlp4lib.cma -pp camlp4of.opt
CAMLOPT = $(CAMLBIN)ocamlopt  -I +camlp4 dynlink.cma camlp4lib.cma -pp camlp4of.opt
MKTOP = $(CAMLBIN)ocamlmktop -I +camlp4 dynlink.cma camlp4lib.cma -pp camlp4of.opt
EXEC = hump

.SUFFIXES: .ml .mli .cmo .cmi .cmx

.ml.cmo:
	$(CAMLC) -c $<

.mli.cmi:
	$(CAMLC) -c $<

$(EXEC): utils.cmo  schemeTypes.cmo reader.cmi reader.cmo printer.cmo repl.cmo 
	$(CAMLC) $(CUSTOM) -o $(EXEC) $(LIBS) $(filter %.cmo, $^)

console: utils.cmo printer.cmo reader.cmo
	$(MKTOP) $^ -o console

all: $(EXEC)

clean::
	rm -f *.cm[iox] *~ .*~ #*#
	rm -f $(EXEC)
	rm -f schemeTypes.mli
	rm -f console
	rm -f $(EXEC).opt
