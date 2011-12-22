open SchemeTypes;;
open Format;;

let rec display ff obj =
  let print_int = fprintf ff "%d" in
  let print_string = fprintf ff "%s" in
  let rec print_separated = function
  [] -> print_string ""
    | [x] -> display ff x
    | x::y -> (display ff x); print_string " "; (print_separated y)
  in
  match obj with
      Int (i) -> print_int i
    | String (s) -> print_string ("\""^s^"\"")
    | Symbol (s) -> print_string ("'"^s)
    | True -> print_string "#t"
    | False -> print_string "#f"
    | List (l) ->
      open_hovbox 1;
      print_string "("; print_separated l; print_string ")"; close_box()
    | _ -> print_string "#<unknown>"
      

