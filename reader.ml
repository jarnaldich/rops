(* Compile with:
   ocamlc -I +camlp4 dynlink.cma camlp4lib.cma -pp camlp4of.opt reader.ml

   Run with:
   camlp4 -parser reader.cmo
 *)
open Camlp4.PreCast;;
open SchemeTypes;;

module SchemeGram = MakeGram(P4Lexer);;
let sexp = SchemeGram.Entry.mk "sexp"

EXTEND SchemeGram
  GLOBAL: sexp;

  lis: 
      [ [ l = LIST0 [ a = sexp -> a ] -> l ] ];

  sexp:
    [ [ LPAREN ; l = lis ; RPAREN -> List l 
      | LPAREN ; l = lis ; "."; b = sexp; RPAREN -> DottedList (l, b) ]
    | [ `INT i -> Int i
      | FALSE -> False
      | TRUE -> True
      | `SYMBOL s -> Symbol s
      | `STRING s -> String s ]
    ];


END;;

let read_stream name = SchemeGram.parse sexp (Loc.mk name) ;;
let read_string = SchemeGram.parse_string sexp (Loc.mk "<string>");;

