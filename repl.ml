open SchemeTypes;;
open Format;;

let print_prompt () =
  print_newline ();
  print_string "~> "; 
  print_flush ();;

let print_obj obj =
  Printer.display Format.std_formatter obj;  print_flush ();;

let s = (Stream.of_channel stdin);;


let rec repl () =
  print_prompt ();
  let s = (Stream.of_channel stdin) in
  print_obj (Evaluator.eval (Reader.read_stream "<stdin>" s));
  print_newline (); print_int (Stream.count s); print_newline();
  repl ();;

let _ = repl ();;
