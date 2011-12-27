(*
  Scanner For A Scheme-like language
 *)
{
open Parser;;
open Lexing;;

exception Eof;;

let incr_linenum lexbuf =
  let pos = lexbuf.Lexing.lex_curr_p in
  lexbuf.Lexing.lex_curr_p <- { pos with
				Lexing.pos_lnum = pos.Lexing.pos_lnum + 1;
				Lexing.pos_bol = pos.Lexing.pos_cnum;
			      };;

(* Strips quotes from the input string *)
let make_string x = STRING (String.sub x 1 ((String.length x) - 2));;

}

let spaces = ['\r' '\t' ' ']
let letter = ['a'-'z' 'A'-'Z']
let digit = ['0'-'9']
let arith_ops = ['*' '/' '+' '-' '=']
let punctuation = ['!' '#'  '$'  '%'  '&'  '|'  '*'  
	           '+' '-'  '/'  ':'  '<'  '='  '>'  '?'  
	           '@'  '^'  '_'  '~'  '\"']
let symbol = (digit|letter)+ (digit|punctuation|letter)*
let scheme_string = '"' (('\\' _ )|[^ '"'])* '"'

rule token = parse
| eof { raise Eof }
| '\n' 
    {
      incr_linenum lexbuf; 
      token lexbuf
    }
| scheme_string as s  { make_string s }
| spaces+ { token lexbuf }
| (digit+ as inum) { INT (int_of_string inum) }
| arith_ops as op { SYMBOL (Char.escaped op) }
| symbol as s { SYMBOL s }
| ';' [^ '\n']* { token lexbuf }	(* eat up one-line comments *)
| '[' { LBRACKET  }
| ']' { RBRACKET }
| '(' { LPAREN }
| ')' { RPAREN }
| "#t" { TRUE }
| "#f" { FALSE }
