open SchemeTypes;;

let rec eval = function
  | List (Symbol "if"::cond::thenc::[elsec]) ->
    (match (eval cond) with
        False -> eval elsec
      | _ -> eval thenc)
  | List (Symbol b::params) ->
    (match Builtins.of_string b with
        Some f -> f (List.map eval params)
      | None -> eval_error "Apply only works with builtins right now.")
  | List _ ->
    eval_error "Apply only works with builtins right now."
  | self_evaluating_obj -> self_evaluating_obj;;

