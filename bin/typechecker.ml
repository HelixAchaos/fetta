(* Nothing to type here *)
let typecheck_typ (_node: Ast.typ) : Typedast.typ = match _node with
| Ast.TBool(text_pos) -> Typedast.TBool(text_pos)
| Ast.TInt(text_pos) -> Typedast.TInt(text_pos)
| Ast.TAny(text_pos) -> Typedast.TAny(text_pos)
| Ast.TNull(text_pos) -> Typedast.TNull(text_pos)
and typecheck_bop (_node: Ast.binary_op) : Typedast.binary_op = match _node with
| Ast.Plus(text_pos) -> Typedast.Plus(text_pos)
|	Ast.Minus(text_pos) -> Typedast.Minus(text_pos)
|	Ast.Mult(text_pos) -> Typedast.Mult(text_pos)
| Ast.Div(text_pos) -> Typedast.Div(text_pos)
|	Ast.Eq(text_pos) -> Typedast.Eq(text_pos)

let infer (_node: Ast.expr) : Types.typ = match 

let typecheck_expr (_node: Ast.expr) : Typedast.expr = match _node with
| Ast.Bool(b, text_pos) -> Typedast.Bool(b, Types.TBool, text_pos)
| Ast.Int(i, text_pos) -> Typedast.Int(i, Types.TInt, text_pos)
| Ast.None(text_pos) -> Typedast.None(Types.TNull, text_pos)
| Ast.BinaryOp(bop, left, right, text_pos) -> Typedast.BinaryOp(bop, left, right, (* SomeType*), text_pos)
| Ast.Var(s, text_pos) -> Typedast.Var(s, (* SomeType*), text_pos)

let typecheck_name (_node: Ast.name) : Typedast.name = match _node with
| name, text_pos -> (name, text_pos)

let typecheck_stmt (_node: Ast.statement) : Typedast.statement = match _node with
| Ast.Assign(target, value, decl_type, text_pos) -> (
  let target = typecheck_name target
  and value = Option.map typecheck_expr value
  and decl_typ = Option.map typecheck_typ decl_typ in
  Typedast.Assign(target, value, decl_type, text_pos)
  )
| Ast.Expr(expr, text_pos) -> (
  let expr = typecheck_expr expr in
  Typedast.Expr(expr, text_pos)
  )
| Ast.Print(expr, text_pos) -> (
  let expr = typecheck_expr expr in
  Typedast.Print(expr, text_pos)
  )

let typecheck_bod (_node: Ast.bod) : Typedast.bod = match _node with
| Ast.Body(stmts) -> Typedast.Body(List.map typecheck_stmt stmts)
   
let typecheck_file (_node: Ast.file) : Typedast.file = match _node with
| Ast.Module(bod) -> Typedast.Module(typecheck_bod bod)



