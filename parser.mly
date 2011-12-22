%{
open SchemeTypes;; 
%}

%token <int> INT
%token <string> SYMBOL STRING 
%token LPAREN RPAREN LBRACKET RBRACKET DOT EOF

%start sexp
%type <SchemeTypes.scheme_obj> sexp

%%

list
    : LPAREN exprlist RPAREN                      {  SchemeTypes.List (List.rev $2) }
    | LBRACKET exprlist RBRACKET                  {  SchemeTypes.List (List.rev $2) }
    | LPAREN exprlist sexp DOT sexp RPAREN        {  SchemeTypes.DottedList ((List.rev ($3::$2)), $5) }
    | LBRACKET exprlist sexp DOT sexp RBRACKET    {  SchemeTypes.DottedList ((List.rev ($3::$2)), $5) }
    ;

exprlist
    :                                             {  []; }
    |  exprlist sexp                              {  $2::$1 }
    ;   

sexp
    : list                                        {  $1; }
    | SYMBOL                                      {  SchemeTypes.Symbol $1 }
    | STRING                                      {  SchemeTypes.String $1 }
    | INT                                         {  SchemeTypes.Int $1; }
    ;
%%
