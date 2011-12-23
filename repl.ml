open SchemeTypes;;
open Format;;
open Lexing;;

let print_prompt () =
  print_newline ();
  print_string "irops> "; 
  print_flush ();;

let print_obj obj =
  Printer.display Format.std_formatter obj;  print_flush ();;

let rec repl s =
  print_obj (Evaluator.eval (Reader.read_stream "<stdin>" s));
  print_prompt ();
  repl s;;

let _ =
  try
    let s = Stream.of_channel stdin in
    print_prompt ();
    repl s
  with
    SchemeLexerError (s, pos) ->
      Format.printf "Error in %s at line %d, char %d: %s@." pos.pos_fname pos.pos_lnum pos.pos_cnum s;
      exit 1 ;;
