(* Compile with:
   ocamlc -I +camlp4 dynlink.cma camlp4lib.cma -pp camlp4of.opt reader.ml

   Run with:
   camlp4 -parser reader.cmo
 *)
open Camlp4.PreCast;;
open SchemeTypes;;

module SchemeGram = MakeGram(Lexer);;

let sexp = SchemeGram.Entry.mk "sexp"

EXTEND SchemeGram
  GLOBAL: sexp;

  lis: 
      [ [ l = LIST0 [ a = sexp -> a ] -> l ] ];

  sexp2:
    [ [ "("; l = lis ; ")" -> List l 
      | "("; l = lis ; "."; b = sexp; ")" -> DottedList (l, b) ]
    | [ `INT (i, _) -> Int i
      | `LIDENT s -> Symbol s
      | "#f" -> False
      | "#t" -> True
      | `SYMBOL s -> Symbol s
      | `STRING (s, _) -> String s ]
    ];

  sexp: [ [ s = sexp2 ; EOI  -> s ] ]; 

END;;

let read_stream name = SchemeGram.parse sexp (Loc.mk name) ;;
let read_string = SchemeGram.parse_string sexp (Loc.mk "<string>");;

