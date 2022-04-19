type text_pos = Lexing.position * Lexing.position

type typ =
(* | T *)
(* |	TBool of T * text_pos *)
| TBool of text_pos
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

type expr = 
| Bool of bool * Types.typ * text_pos
| Int of int * Types.typ * text_pos
|	BinaryOp of binary_op * expr * expr * Types.typ * text_pos
|	Var of string * Types.typ * text_pos
| None of Types.typ * text_pos
and name = string * text_pos  (* should be `expr * text_pos` because of `Name`? *)
and statement = 
  | Assign of name * (expr option) * (typ option) * text_pos
  | Expr of expr * text_pos
  | Print of expr * text_pos
and bod = 
  | Body of statement list

type file = 
| Module of bod
