(* loop labels: while_stmt, break_stmt, continue_stmt *)
(* type label = 
| Label of string * text_pos *)

(* text position for error messages *)
(* type lineno = int
type col_offset = int
type end_lineno = int
type end_col_offset = int *)
(* type text_pos = lineno * col_offset * end_lineno * end_col_offset *)
type text_pos = Lexing.position * Lexing.position



type typ =
|	TBool of text_pos
|	TInt of text_pos
(* | TFun of typ list * typ *)
| TAny of text_pos
| TNull of text_pos


type binary_op = 
|	Plus of text_pos
|	Minus of text_pos
|	Mult of text_pos
|	Div of text_pos
|	Eq of text_pos
(* |	Mod
|	And
|	Or
|	Neq
|	Lt
|	Ltq
|	Gt
|	Gtq *)

(* type unary_op =  *)

type expr = 
| Bool of bool * text_pos
| Int of int * text_pos
|	BinaryOp of binary_op * expr * expr * text_pos
|	Var of string * text_pos
(* | Call of expr * expr list * text_pos *)
| None of text_pos
and name = string * text_pos  (* is `expr` because of `Name` *)
and statement = 
  | Assign of name * (expr option) * (typ option) * text_pos
  (* | If of expr * bod * (or_else option) * text_pos *)
  (* | While of expr * bod * (or_else option) * label option * text_pos
  | Break of label option * text_pos
  | Continue of label option * text_pos *)
  | Expr of expr * text_pos
  | Print of expr * text_pos
  (* | FunctionDef of name * (name * typ) list * typ * bod * text_pos
  | Return of expr option * text_pos *)

and bod = 
  | Body of statement list
(* and or_else = bod *)

type file = 
| Module of bod



(* $startpos, $endpos, $startofs, $endofs *)