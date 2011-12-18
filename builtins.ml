open SchemeTypes;;
type builtin =
    (SchemeTypes.scheme_obj list) -> (SchemeTypes.scheme_obj option);;

let make_arith_op_builtin_func (base:int) (f:int -> int -> int) params =
        Some (List.fold_left (fun x -> fun y -> Int (f (lift_int x) (lift_int y))) (Int base) params) ;;

let builtin_begin params =
  match (List.rev params) with
      hd::tl -> Some hd
    | [] -> None;; 

let builtin_equal (params:scheme_obj list) : (scheme_obj option) =
  Some (scheme_obj_of_bool (List.for_all (( = ) (List.hd params)) (List.tl params)));;

let builtin_option (o:string) : builtin option =
  match o with
    "+" -> Some (make_arith_op_builtin_func 0 ( + ))
  | "-" -> Some (make_arith_op_builtin_func 0 ( - ))
  | "*" -> Some (make_arith_op_builtin_func 1 ( * ))
  | "/" -> Some (make_arith_op_builtin_func 1 ( / ))
  | "=" -> Some (builtin_equal)
  | "begin" -> Some (builtin_begin)
  | "list" -> Some (fun params -> (Some (List params)))
  | _ -> None
;;

