type builtin =
    (SchemeTypes.scheme_obj list) -> SchemeTypes.scheme_obj;;

val of_string : string -> builtin option;;
