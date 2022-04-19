open Helper

(* consider using https://ocaml.org/api/Format.html, especially those break_points. *)

type _settings = { mutable indent : int}
let settings = { indent = 0 }

let rec format (i_level: int) (dump: 'a -> 'b -> string) (_node: 'a) : string =
  "\n" ^ (string_n_times " " (settings.indent * i_level)) ^ (dump _node (i_level + 1))

let rec dump_loc (p: Ast.text_pos) (i_level: int) : string = match p with
| a, b -> Printf.sprintf "In file[%s, %s]: line_num[%d, %d]: bol[%d, %d]: cnum[%d, %d]" a.pos_fname b.pos_fname  a.pos_lnum  b.pos_lnum  a.pos_bol  b.pos_bol  a.pos_cnum  b.pos_cnum
and dump_int (num: int) (_: int) : string = string_of_int num
and dump_bool (b: bool) (_: int) : string = string_of_bool b
and dump_string (s: string) (_: int) : string = s
and dump_expr (_node: Ast.expr) (i_level: int) : string = 
  (match _node with
  | Ast.BinaryOp(bop, left, right, loc) -> (
    let bop = format i_level dump_bop bop
    and left = format i_level dump_expr left
    and right = format i_level dump_expr right
    and loc = format i_level dump_loc loc in
    Printf.sprintf "BinaryOp(  # operator : operand1: operand2 %s, %s, %s, %s)" bop left right loc)
  | Ast.Int(num, loc) -> (
    let num = format i_level dump_int num
    and loc = format i_level dump_loc loc in
    Printf.sprintf "Int(  # value %s, %s)" num loc 
    )
  | Ast.Bool(b, loc) -> (
    let b = string_of_bool b
    and loc = format i_level dump_loc loc in
    Printf.sprintf "Bool(  # value %s, %s)" b loc 
    )
  | Ast.None(loc) -> (
    let loc = format i_level dump_loc loc in
    Printf.sprintf "None(%s)" loc
    )
  | Ast.Var(v, loc) -> (
    let v = format i_level dump_string v
    and loc = format i_level dump_loc loc in
    Printf.sprintf "Var(  # name %s, %s)" v loc
    )
  )
  (* | Ast.Call(func, params, loc) -> "Call(" ^ format i_level dump_expr func ^ ", " ^ (string_of_list params (format i_level dump_expr )) ^ "," ^ format i_level dump_loc loc ^ ")" *)
(* and dump_label (label: Ast.label) = 
  match label with
  | Ast.Label(lbl_name, loc) -> "Label(" ^ lbl_name ^ "," ^ format i_level dump_loc loc ^ ")" *)
and dump_bop (_node: Ast.binary_op) (i_level: int) : string =
  (match _node with
  | Ast.Plus(loc) -> (
    let loc = format i_level dump_loc loc in
    Printf.sprintf "Plus(%s)" loc
    )
  | Ast.Minus(loc) -> (
    let loc = format i_level dump_loc loc in
    Printf.sprintf "Minus(%s)" loc
    )
  | Ast.Mult(loc) -> (
    let loc = format i_level dump_loc loc in
    Printf.sprintf "Mult(%s)" loc
    )
  | Ast.Div(loc) -> (
    let loc = format i_level dump_loc loc in
    Printf.sprintf "Div(%s)" loc
    )
  | Ast.Eq(loc) -> (
    let loc = format i_level dump_loc loc in
    Printf.sprintf "Eq(%s)" loc
    )
  )
and dump_typ (_node: Ast.typ) (i_level: int) : string = 
  (match _node with
  |	TBool(loc) -> (
    let loc = format i_level dump_loc loc in
    Printf.sprintf "TBool(%s)" loc
    )
  |	TInt(loc) -> (
    let loc = format i_level dump_loc loc in
    Printf.sprintf "TInt(%s)" loc
    )
  | TAny(loc) -> (
    let loc = format i_level dump_loc loc in
    Printf.sprintf "TAny(%s)" loc
    )
  | TNull(loc) -> (
    let loc = format i_level dump_loc loc in
    Printf.sprintf "TNull(%s)" loc
    )
  )
and dump_name (_name: string * Ast.text_pos) (i_level: int) : string = 
  match _name with
  | id, loc -> (
    let id = format i_level dump_string id
    and loc = format i_level dump_loc loc in
    Printf.sprintf "Name(  #id %s, %s)" id loc
    )
and dump_stmt (_node: Ast.statement) (i_level: int) : string = 
  (match _node with
  | Ast.Assign(name, expr, typ, loc) -> (
    let expr = Option.fold ~none:"None" ~some:(format i_level dump_expr) expr
    and typ = Option.fold ~none:"None" ~some:(format i_level dump_typ) typ
    and name = format i_level dump_name name in
    Printf.sprintf "Assign( # target: expr: type%s, %s, %s, %s)" name expr typ (format i_level dump_loc loc)
    )
  (* | Ast.If(test, body, else_clause) -> "If(" ^ dump_expr test ^ "," ^ dump_body body ^ "," ^ dump_orelse else_clause ^ ")"
  | Ast.While(test, body, else_clause, label) -> "While(" ^ dump_expr test ^ "," ^ dump_body body ^ "," ^ dump_orelse else_clause ^ "," ^ dump_label label ^ ")" *)
  | Ast.Expr(expr, loc) -> (
    let expr = format i_level dump_expr expr
    and loc = format i_level dump_loc loc in
    Printf.sprintf "Expr(  # value %s, %s)" expr loc
    )
  | Ast.Print(expr, loc) -> (
    let expr = format i_level dump_expr expr
    and loc = format i_level dump_loc loc in
    Printf.sprintf "Print(  # expr %s, %s)" expr loc
    )
  )
  (* | Ast.Break label -> "Break(" ^ dump_label label ^ ")" *)
  (* | Ast.Continue label -> "Continue(" ^ dump_label label ^ ")" *)
  (* | Ast.Return e -> "Return(" ^ (Option.value (Option.map dump_expr e) ~default:"None") ^ ")" *)
  (* | Ast.FunctionDef(name, params, ret, bod) -> "FunctionDef(" ^ name ^ "," ^ (string_of_list params (fun (typ, nomen) -> typ ^ " " ^ nomen)) ^ "," ^ ret ^ "," ^dump_body bod ^ ")" *)
and dump_body (_node: Ast.bod) (i_level: int) : string = 
  (match _node with
  | Body stmts -> (
    let stmts = string_of_list stmts (format i_level dump_stmt) in
    Printf.sprintf "Body(%s)" stmts
    )
  )
(* and dump_orelse (_node: Ast.or_else option) (i_level: int) : string = 
  match _node with
  | None -> ""
  | Some OrElse bod -> "OrElse(" ^ (dump_body indent bod) ^ ")" *)
and dump_f ?(indent: int = 4) (_node: Ast.file) : string =
  settings.indent <- indent;
  let i_level = 1 in
    (match _node with
    | Module bod -> (
      let bod = format i_level dump_body bod in
      Printf.sprintf "File(%s)" bod
      )
    )
