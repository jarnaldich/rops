let (|>) (p : 'a) (f : 'a -> 'b) = f p;;

let rec prefix0 n l acum = 
  match n with
      0 -> List.rev acum
    | i -> prefix0 (n - 1) (List.tl l) ((List.hd l)::acum);;
let prefix n l = prefix0 n l [];;

let rec split_at0 n (seen, unseen) =
  match n with
      0 -> ((List.rev seen), unseen)
    | i -> split_at0 (n - 1) (((List.hd unseen)::seen), (List.tl unseen));;
let split_at n l = split_at0 n ([], l);;

let rec loop_acum n f initial =
  match n with
      0 -> initial
    | i -> loop_acum (i - 1) f (f initial);;

(* Option data type helpers *)
let is_some = function
    Some x -> true
  | None -> false

let is_none x = not (is_some x);;

let get_some = function
    Some x -> x
  | None -> raise Not_found
