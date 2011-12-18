(* *)
open Camlp4.PreCast;; 
module SchemeGrammar = MakeGram(Lexer);;

type t = Int of int
	| String of string
	| Symbol of string
	| List of t list;;

let sexp = SchemeGrammar.Entry.mk "sexp";;

EXTEND SchemeGrammar
	GLOBAL: sexp;
	sexp:
	[ "atom"
		[ `LIDENT s -> 
