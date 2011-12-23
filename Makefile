# Makefile for ROP scheme.
#
# TODO: Add rules for generating a native-code interpreter.
#

CAMLBIN=
CAMLC = $(CAMLBIN)ocamlc -I +camlp4 dynlink.cma camlp4lib.cma -pp $(CAMLBIN)camlp4of.opt
CAMLOPT = $(CAMLBIN)ocamlopt  -I +camlp4 dynlink.cma camlp4lib.cma -pp $(CAMLBIN)camlp4of.opt
CAMLLEX = $(CAMLBIN)ocamllex
CAMLYACC = $(CAMLBIN)ocamlyacc
MKTOP = $(CAMLBIN)ocamlmktop -I +camlp4 dynlink.cma camlp4lib.cma -pp $(CAMLBIN)camlp4of.opt
EXEC = rops.exe

.SUFFIXES: .ml .mli .cmo .cmi .cmx .mly .mll

.mly.ml:
	$(CAMLYACC) $<

.mll.ml:
	$(CAMLLEX) $<

.ml.cmo:
	$(CAMLC) -c $<

.mli.cmi:
	$(CAMLC) -c $<

all: $(EXEC)

$(EXEC): schemeTypes.cmo p4Error.cmo lexer.cmo p4Lexer.cmo utils.cmo reader.cmi builtins.cmi builtins.cmo evaluator.cmo reader.cmo printer.cmo repl.cmo 
	$(CAMLC) -o $(EXEC) $(filter %.cmo, $^)

parser.cmi parser.cmo: parser.ml

console: utils.cmo lexer.cmo p4Lexer.cmo printer.cmo schemeTypes.cmo reader.cmo builtins.cmo evaluator.cmo
	$(MKTOP) $^ -o console


clean::
	rm -f *.cm[iox] *~ .*~ #*#
	rm -f $(EXEC)
	rm -f schemeTypes.mli
	rm -f parser.ml parser.mli
	rm -f lexer.ml lexer.mli
	rm -f console
	rm -f $(EXEC).opt
