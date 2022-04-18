type typ = 
|	TBool
|	TInt
|	TNull
| TFun of typ list * typ
| TAny
(* | TUnion *)

type obj =
| Bool of bool
| Int of int
| None
| Fun of (typ * Ast.name) list * typ * Ast.bod

let issubclass (a: typ) (b: typ) : bool = match a, b with 
| TBool, TInt -> true
| _, TAny -> true
| _ -> a == b

let rec type_of_value (v: obj) : typ = match v with
| Bool b -> TBool
| Int i -> TInt
| None -> TNull
| Fun(params, ret, bod) -> TFun(List.map (fun (typ, id) -> typ) params, ret)

let rec string_of_type (t: typ) : string = match t with
|	TBool -> "bool"
|	TInt -> "int"
|	TNull -> "null"
| TFun(params, ret) -> "fun(" ^ Helper.string_of_list params string_of_type ^ ", " ^ string_of_type ret ^ ")"
| TAny -> "any"

let rec string_of_value (v: obj) : string = match v with
| Bool b -> string_of_bool b
| Int i -> string_of_int i
| None -> "None"
(* doesn't show body *)
| Fun(params, ret, bod) -> "Fun(" ^ (Helper.string_of_list params (fun (typ, (nomen, _)) -> (string_of_type typ) ^ " " ^ nomen)) ^ ", " ^ string_of_type ret ^ ", <body>)"

(* use when types are dynamically grabbed rather than hardcoded *)
let type_of_string (s: string) : typ = match s with
| "bool" -> TBool
| "int" -> TInt
| "null" -> TNull
| "any" -> TAny
| _ -> Stdlib.failwith ("Invalid type name " ^ s)

let type_of_ast_type (t: Ast.typ) : typ = match t with
| Ast.TBool -> TBool
|	Ast.TInt -> TInt
(* | TFun of typ list * typ *)
| Ast.TAny -> TAny
| Ast.TNull -> TNull