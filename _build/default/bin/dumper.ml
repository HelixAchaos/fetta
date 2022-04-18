open Helper

type _settings = { mutable indent : int}
let settings = { indent = 0 }

let rec format (i_level: int) (dump: 'a -> 'b -> string) (_node: 'a) : string =
   "\n" ^ (string_n_times " " (settings.indent * i_level)) ^ (dump _node (i_level + 1))

let rec dump_expr (_node: Ast.expr) (i_level: int) : string = 
  (match _node with
  | Ast.BinaryOp(bop, left, right, loc) -> ("BinaryOp(" ^ (
        match bop with
        | Ast.Plus(loc) -> "Plus(" ^ string_of_loc loc ^ ")"
        | Ast.Minus(loc) -> "Minus(" ^ string_of_loc loc ^ ")"
        | Ast.Mult(loc) -> "Mult(" ^ string_of_loc loc ^ ")"
        | Ast.Div(loc) -> "Div(" ^ string_of_loc loc ^ ")"
        | Ast.Eq(loc) -> "Eq(" ^ string_of_loc loc ^ ")"
        ) ^ "," ^ format i_level dump_expr left ^ "," ^ format i_level dump_expr right ^ "," ^ string_of_loc loc ^ ")")
  | Ast.Int(num, loc) -> "Int(" ^ string_of_int num ^ "," ^ string_of_loc loc ^ ")" 
  | Ast.Bool(b, loc) -> "Bool(" ^ string_of_bool b ^ "," ^ string_of_loc loc ^ ")" 
  | Ast.None(loc) -> "None(" ^ string_of_loc loc ^ ")"
  | Ast.Var(v, loc) -> "Var(" ^ v ^ "," ^ string_of_loc loc ^ ")")
  (* | Ast.Call(func, params, loc) -> "Call(" ^ format i_level dump_expr func ^ ", " ^ (string_of_list params (format i_level dump_expr )) ^ "," ^ string_of_loc loc ^ ")" *)
(* and dump_label (label: Ast.label) = 
  match label with
  | Ast.Label(lbl_name, loc) -> "Label(" ^ lbl_name ^ "," ^ string_of_loc loc ^ ")" *)
and dump_typ (_node: Ast.typ) (i_level: int) : string = 
  (match _node with
  |	TBool(loc) -> "TBool(" ^ string_of_loc loc ^ ")"
  |	TInt(loc) -> "TInt(" ^ string_of_loc loc ^ ")"
  | TAny(loc) -> "TAny(" ^ string_of_loc loc ^ ")"
  | TNull(loc) -> "TNull(" ^ string_of_loc loc ^ ")")
and dump_stmt (_node: Ast.statement) (i_level: int) : string = 
  (match _node with
  | Ast.Assign((id, _), expr, typ, loc) -> (let expr = Option.fold ~none:"None" ~some:(format i_level dump_expr) expr
    and typ = Option.fold ~none:"None" ~some:(format i_level dump_typ) typ
    in "Assign(" ^ id ^ "," ^ expr ^ "," ^ typ ^ "," ^ string_of_loc loc ^ ")")
  (* | Ast.If(test, body, else_clause) -> "If(" ^ dump_expr test ^ "," ^ dump_body body ^ "," ^ dump_orelse else_clause ^ ")"
  | Ast.While(test, body, else_clause, label) -> "While(" ^ dump_expr test ^ "," ^ dump_body body ^ "," ^ dump_orelse else_clause ^ "," ^ dump_label label ^ ")" *)
  | Ast.Expr(expr, loc) -> "Expr(" ^ format i_level dump_expr expr ^ "," ^ string_of_loc loc ^ ")"
  | Ast.Print(expr, loc) -> "Print(" ^ format i_level dump_expr expr ^ "," ^ string_of_loc loc ^ ")")
  (* | Ast.Break label -> "Break(" ^ dump_label label ^ ")" *)
  (* | Ast.Continue label -> "Continue(" ^ dump_label label ^ ")" *)
  (* | Ast.Return e -> "Return(" ^ (Option.value (Option.map dump_expr e) ~default:"None") ^ ")" *)
  (* | Ast.FunctionDef(name, params, ret, bod) -> "FunctionDef(" ^ name ^ "," ^ (string_of_list params (fun (typ, nomen) -> typ ^ " " ^ nomen)) ^ "," ^ ret ^ "," ^dump_body bod ^ ")" *)
and dump_body (_node: Ast.bod) (i_level: int) : string = 
  (match _node with
  | Body stmts -> "Body(" ^ (string_of_list stmts (format i_level dump_stmt)) ^ ")")
(* and dump_orelse (_node: Ast.or_else option) (i_level: int) : string = 
  match _node with
  | None -> ""
  | Some OrElse bod -> "OrElse(" ^ (dump_body indent bod) ^ ")" *)
and dump_f ?(indent: int = 4) (_node: Ast.file) : string =
  settings.indent <- indent;
  let i_level = 1 in
    (match _node with
    | Module bod -> "File(" ^ format i_level dump_body bod ^ ")")
