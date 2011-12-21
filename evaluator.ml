open SchemeTypes;;

let rec eval = function
  | List (Symbol b::params) ->
    (match Builtins.of_string b with
        Some f -> f (List.map eval params)
      | None -> failwith "Apply does not support closures yet")
  | self_evaluating_obj -> self_evaluating_obj;;

