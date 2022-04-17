type typ = 
|	TBool
|	TInt
|	TUnit
(* | TString *)
(* | TList of typ *)
| TFun of typ list * typ
| TAny
(* | TUnion of typ list *)
(* | TCustom of Ast.id *)
(* |	TList of typ *)

type obj =
| Bool of bool
| Int of int
| Unit
(* | String of string *)
(* | List of obj list *)
| Fun of (typ * Ast.id) list * typ * Ast.bod
(* | CustomObject *)

let rec type_of_value (v: obj) : typ = match v with
| Bool b -> TBool
| Int i -> TInt
| Unit -> TUnit
| Fun(params, ret, bod) -> TFun(List.map (fun (typ, id) -> typ) params, ret)
(* | String s -> TString
| List o_l -> TList (type_of_value (List.hd o_l)) (* todo: make list[int | str] for [1, 'a'] rather than just assuming homogenity *) *)
(* | CustomObject -> TCustom *)

let rec string_of_type (t: typ) : string = match t with
|	TBool -> "bool"
|	TInt -> "int"
|	TUnit -> "unit"
| TFun(params, ret) -> "fun(" ^ Helper.string_of_list params string_of_type ^ ", " ^ string_of_type ret ^ ")"
| TAny -> "any"
(* | TList t -> "list"
| TString -> "string" *)
(* | TUnion t_l -> Helper.string_of_list ~sep:"|" t_l string_of_type *)
(* | TCustom name -> name *)

let rec string_of_value (v: obj) : string = match v with
| Bool b -> string_of_bool b
| Int i -> string_of_int i
| Unit -> "()"
| Fun(params, ret, bod) -> "Fun(" ^ (Helper.string_of_list params (fun (typ, nomen) -> (string_of_type typ) ^ " " ^ nomen)) ^ ", " ^ string_of_type ret ^ ")"
(* | String s -> s *)
(* | List l -> Helper.string_of_list l string_of_value *)

let issubclass (a: typ) (b: typ) : bool = match a, b with 
| TBool, TInt -> true
| _, TAny -> true
| _ -> a == b  (* todo: implement subclassing rather than a simple id check *)

let types: (Ast.id, typ) Hashtbl.t = Hashtbl.create 1021

let type_of_string (s: Ast.id) : typ = match Hashtbl.find_opt types s with
| Some t -> t
| None -> Stdlib.failwith "type not found"

let () = Hashtbl.add types "bool" TBool;
  Hashtbl.add types "int" TInt;
  Hashtbl.add types "unit" TUnit;
  Hashtbl.add types "any" TAny;

  (* Hashtbl.add types "list" TList; *)
  (* Hashtbl.add types "string" TString *)
  (* Hashtbl.add types "custom" TCustom *)
  