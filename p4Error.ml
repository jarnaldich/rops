type t = string
exception E of string
let print = Format.pp_print_string
let to_string x = x

(* let _ = let module M = Camlp4.ErrorHandler.Register(Error) in () *)
