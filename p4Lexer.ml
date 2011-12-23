open Lexing;;
open SchemeTypes;;

module Loc = Camlp4.PreCast.Loc
module Error = P4Error
type token = SchemeTypes.token

module Token =
  struct 
    module Loc = Loc
    module Error = Error

    type t = token
    let to_string t =
      let sf = Printf.sprintf in
      match t with
      | INT s     -> sf "INT %d" s
      | SYMBOL s  -> sf "SYMBOL \"%s\"" s
      | STRING s  -> sf "STRING \"%s\"" s
      | TRUE -> sf "TRUE"
      | FALSE -> sf "FALSE"
      | LBRACKET -> "]"
      | RBRACKET -> "["
      | LPAREN -> "("
      | RPAREN -> ")"
            
    let print ppf x = Format.pp_print_string ppf (to_string x)
        
    let match_keyword _  _ = false
        
    let extract_string =
      function
        | SYMBOL s | STRING s -> s
        | INT i -> string_of_int i
        | tok ->
            invalid_arg
              ("Cannot extract a string from this token: " ^
               to_string tok)


    module Filter =
      struct
        type token_filter = (t, Loc.t) Camlp4.Sig.stream_filter
        type t = unit
        let mk _ = ()
        let filter _ strm = strm
        let define_filter _ _ = ()
        let keyword_added _ _ _ = ()
        let keyword_removed _ _ = ()
      end
  end





(********************************************************************)
let lexing_store s buff max =
  let rec self n s =
    if n >= max then n
    else
      match Stream.peek s with
      | Some x ->
	  Stream.junk s;
	  buff.[n] <- x;
	  succ n
      | _ -> n
  in
  self 0 s;;
    
let mk () (loc:Loc.t) strm =
  let lb = Lexing.from_function (lexing_store strm) in
  let next _ =
    let tok =
      try
        Lexer.token lb
      with
        _ -> failwith "Lexing Error"
    in
    Some(tok, loc)
  in
  Stream.from next;;
    
