let rec dump_expr (_node: Ast.expr) : string =
  match _node with
  | Ast.BinaryOp(bop, left, right) -> ("BinaryOp(" ^ (
        match bop with
        | Ast.Plus -> "Plus"
        | Ast.Minus -> "Minus"
        | Ast.Mult -> "Mult"
        | Ast.Div -> "Div"
        | Ast.Eq -> "Eq"
        ) ^ "," ^ (dump_expr left) ^ "," ^ dump_expr(right) ^ ")")
  | Ast.Int(num) -> "Int(" ^ string_of_int num ^ ")" 
  | Ast.Bool(b) -> "Bool(" ^ string_of_bool b ^ ")" 
  (* | Ast.Unit -> "Unit()" *)
  | Ast.Name(v) -> v
  | Ast.Call(func, params) -> "Call(" ^ dump_expr func ^ ", " ^ (Helper.string_of_list params dump_expr) ^ ")"
  (* UnaryOp *)
and dump_label (label: Ast.id option) = 
  match label with
  | Some l -> l
  | None -> "None"
and dump_stmt (_node: Ast.statement) : string =
  match _node with
  | Ast.Assign(id, expr, typ) -> (let expr = (match expr with
    | None -> "None"
    | Some expr -> dump_expr expr) in let typ = (match typ with
      | None -> "None"
      | Some typ -> typ) in "Assign(" ^ id ^ "," ^ expr ^ "," ^ typ ^ ")")
  | Ast.If(test, body, else_clause) -> "If(" ^ dump_expr test ^ "," ^ dump_body body ^ "," ^ dump_orelse else_clause ^ ")"
  | Ast.While(test, body, else_clause, label) -> "While(" ^ dump_expr test ^ "," ^ dump_body body ^ "," ^ dump_orelse else_clause ^ "," ^ dump_label label ^ ")"
  | Ast.Expr expr -> "Ast.expr(" ^ dump_expr expr ^ ")"
  | Ast.Print expr -> "print(" ^ dump_expr expr ^ ")"
  | Ast.Break label -> "Break(" ^ dump_label label ^ ")"
  | Ast.Continue label -> "Continue(" ^ dump_label label ^ ")"
  | Ast.Return e -> "Return(" ^ (Option.value (Option.map dump_expr e) ~default:"None") ^ ")"
  | Ast.FunctionDef(name, params, ret, bod) -> "FunctionDef(" ^ name ^ "," ^ (Helper.string_of_list params (fun (typ, nomen) -> typ ^ " " ^ nomen)) ^ "," ^ ret ^ "," ^dump_body bod ^ ")"
and dump_body (_node: Ast.bod) : string = 
  match _node with
  | Body stmts -> "Body(" ^ (Helper.string_of_list stmts dump_stmt) ^ ")"

and dump_orelse (_node: Ast.or_else option) : string = 
  match _node with
  | None -> ""
  | Some OrElse bod -> "OrElse(" ^ (dump_body bod) ^ ")"

and dump_f (_node: Ast.f) : string =
  match _node with
  | File bod -> "File(" ^ dump_body bod ^ ")"
