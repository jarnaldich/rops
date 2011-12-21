open SchemeTypes;;
type builtin =
    (SchemeTypes.scheme_obj list) -> SchemeTypes.scheme_obj;;

let make_arith_op_builtin_func (base:int) (f:int -> int -> int) params =
  List.fold_left (fun x -> fun y -> Int (f (lift_int x) (lift_int y))) (Int base) params;;

let builtin_equal (params:scheme_obj list) : scheme_obj =
  scheme_obj_of_bool (List.for_all (( = ) (List.hd params)) (List.tl params));;

let of_string (o:string) : builtin option =
  match o with
    "+" -> Some (make_arith_op_builtin_func 0 ( + ))
  | "-" -> Some (make_arith_op_builtin_func 0 ( - ))
  | "*" -> Some (make_arith_op_builtin_func 1 ( * ))
  | "/" -> Some (make_arith_op_builtin_func 1 ( / ))
  | "=" -> Some (builtin_equal)
  | "list" -> Some (fun params -> (List params))
  | _ -> None
;;

