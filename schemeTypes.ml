type scheme_obj =
    | Int of int
    | True
    | False
    | String of string
    | Symbol of string
    | List of scheme_obj list
    | DottedList of (scheme_obj list) * scheme_obj;;
