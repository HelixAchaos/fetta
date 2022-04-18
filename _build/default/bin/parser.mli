
(* The type of tokens. *)

type token = 
  | TRUE
  | TNULL
  | TINT
  | TBOOL
  | TANY
  | SEMICOLON
  | RPAREN
  | PRINT
  | PLUS
  | NULL
  | MULTIPLY
  | MINUS
  | LPAREN
  | INT of (int)
  | ID of (string)
  | FALSE
  | EQUALS
  | EQEQ
  | EOF
  | DIVIDE
  | COLON

(* This exception is raised by the monolithic API functions. *)

exception Error

(* The monolithic API. *)

val main: (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (Ast.file)
