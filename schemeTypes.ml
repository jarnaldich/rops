type scheme_obj =
    | Int of int
    | True
    | False
    | String of string
    | Symbol of string
    | List of scheme_obj list
    | DottedList of (scheme_obj list) * scheme_obj;;

let lift_int = function
    | Int (i) -> i
    | _ -> failwith "Invalid integer cast";;

let scheme_obj_of_bool = function
  | true -> True
  | false -> False;;
