open SchemeTypes;;
open Format;;

let print_prompt () =
  print_newline ();
  print_string "~> "; 
  print_flush ();;

let print_obj obj =
  Printer.display Format.std_formatter obj; print_flush ();;

let _ =
    print_obj (Reader.read_str (read_line ()));;
