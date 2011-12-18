type builtin =
    (SchemeTypes.scheme_obj list) -> (SchemeTypes.scheme_obj option);;

val builtin_option : string -> builtin option;;
