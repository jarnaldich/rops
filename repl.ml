open SchemeTypes;;
open Format;;
open Lexing;;

let print_prompt () =
  print_newline ();
  print_string "~> "; 
  print_flush ();;

let print_obj obj =
  Printer.display Format.std_formatter obj;  print_flush ();;

let rec repl lexbuf =
  print_prompt ();
  print_obj (Evaluator.eval (Parser.sexp Lexer.token lexbuf));
  repl lexbuf;;

let _ =
  try
    let lexbuf = Lexing.from_channel stdin in
    lexbuf.lex_curr_p <- { lexbuf.lex_curr_p with pos_fname = "stdin" };
    print_prompt ();
    repl lexbuf
  with
    Lexer.Eof ->
      flush stdout;
      exit 0
  | SchemeLexerError (s, pos) ->
      Format.printf "Error in %s at line %d, char %d: %s@." pos.pos_fname pos.pos_lnum pos.pos_cnum s;
      exit 1 ;;
