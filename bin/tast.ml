type id = string

type binary_op = 
|	Plus
|	Minus
|	Mult
|	Div
|	Eq

type expr = 
| Bool of bool
| Int of int
|	BinaryOp of binary_op * expr * expr
(* |	UnaryOp of unary_op * expr *)
|	Name of id
| Call of expr * expr list
(* | Unit *)

(* type typ = 
|	TBool
|	TInt
|	TUnit
|	TList of typ *)

type or_else = 
  | OrElse of bod
and statement = 
  | Assign of id * (expr option) * (id option)  (* typ option? *)
  | If of expr * bod * (or_else option)
  | While of expr * bod * (or_else option) * (id option)
  | Break of id option
  | Continue of id option
  | Expr of expr
  | Print of expr
  | FunctionDef of id * (id * id) list * id * bod
  | Return of expr option
  (* | For of target * iter * body * orelse
  | While of test * body * orelse *)
and bod = 
  | Body of statement list

(** The type of the abstract syntax tree (AST). *)
type f =
  | File of bod


(* type 'a node = [> `Constant | `UnaryOp | `BinaryOp | `Name | `OrElse | `Expr | `Assign | `If | `Body | `File | `f] as 'a *)
(* type 'a node = {data: 'a} *)


(*
|	TVar of id	(*	TVar "a" represents the type variable 'a. It is used to implement polymorphism.	*)
|	Arrow of typ * typ	(*	Arrow are our representations of function types. Arrow (t,t') is the type of a function t -> t'.	*)
*)