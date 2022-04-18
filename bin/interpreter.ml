type break_or_continue_or_return = 
| Break of Ast.label option
| Continue of Ast.label option
| Return of Types.obj

type stmt_val = break_or_continue_or_return option

type state = (Ast.id, Types.typ * (Types.obj option)) Hashtbl.t

let throw_away (_: 'a) : stmt_val = None

let print_state (st: state) : unit = 
  Hashtbl.iter (fun id (typ, e_opt) -> Printf.printf "%s -> (%s, %s)\n" id (Types.string_of_type typ) (match e_opt with 
  | Some e -> Types.string_of_value e
  | None -> "None")) st

let rec stream_take_until (stream: 'a Stream.t) (stop_cond: 'a -> bool) : 'a = 
  try (let e = Stream.next stream in
    if stop_cond e then e else stream_take_until stream stop_cond
  )
  with Stream.Failure -> None

let stream_map f stream =
  let next _ =
    try Some (f (Stream.next stream))
    with Stream.Failure -> None in
  Stream.from next

let rec lookup (scope: state list) (name: Ast.id) : Types.typ * (Types.obj option) =
  match scope with
  | [] -> Stdlib.failwith ("Name(" ^ name ^ ") Not found")
  | x :: xs -> if Hashtbl.mem x name then Hashtbl.find x name else lookup xs name

let type_of_name (scope: state) (name: Ast.id) : Types.typ =
  if Hashtbl.mem scope name then (match Hashtbl.find scope name with
  | typ, _ -> typ) else Stdlib.failwith ("Name(" ^ name ^ ") Not found")

let rec initialize (scope: state list) (name: Ast.id) (v: Types.obj) (t_o_v: Types.typ): stmt_val = 
  match scope with
  | [] -> Stdlib.failwith ("Attempted initialization to an undeclared name  : Can't assign to empty scope")
  | x :: xs -> if Hashtbl.mem x name
    then (let t_o_n = (type_of_name x name) in (if Types.issubclass t_o_v t_o_n
      then throw_away (Hashtbl.add x name (t_o_n, Some v))
      else (Stdlib.failwith "Attempted Intialization Failed: value's type is not a subclass of named type.")))
    else initialize xs name v t_o_v

let declare (scope: state list) (name: Ast.id) (t: Types.typ) : stmt_val = let st = List.hd scope in
  match Hashtbl.find_opt st name with
  | Some v -> Stdlib.failwith "Attempted declaration of a name that has already been declared"
  | None -> throw_away (Hashtbl.add (List.hd scope) name (t, None))


(* don't need a `pop_env` rn because when `exec_body` finishes, the added env disappears *)
(* let pop_env (scope: state list) : state list = 
  match scope with
  | [] -> Stdlib.failwith "Tried to pop global??"
  | x :: xs -> xs *)

let add_env (scope: state list) : state list = 
  List.concat [[Hashtbl.create 1021]; scope]


let assign (scope: state list) (id: Ast.id) (d_t_opt: Types.typ option) (v_opt: (Types.typ * Types.obj) option) : stmt_val =
  let _ = Option.bind d_t_opt (declare scope id) in (match v_opt with
  | Some(v_t, v_o) -> initialize scope id v_o v_t
  | None -> None)

let boolify ((t, obj): Types.typ * Types.obj) : bool = (match t with
| Types.TBool
| Types.TInt -> (match obj with
  | Types.Bool(b) -> b
  | Types.Int(i) -> i != 0
  | _ -> Stdlib.failwith "somehow an object of some type that isn't bool or int was given the static-type int"
  )
| _ -> Stdlib.failwith ("Type " ^ (Types.string_of_type t) ^ " ain't boolify-able."))

let rec eval_expr (scope: state list) (_node: Ast.expr) : (Types.typ * Types.obj) =
  match _node with
  | Ast.BinaryOp(bop, left, right) -> (
    let left = eval_expr scope left in 
      let right = eval_expr scope right in
        match bop with
        | Ast.Plus -> (match left, right with
          | (Types.TInt, Types.Int(i1)), (Types.TInt, Types.Int(i2)) -> (Types.TInt, Types.Int(i1 + i2))
          | _ -> Stdlib.failwith "bad addition types")
        | Ast.Minus -> (match left, right with
        | (Types.TInt, Types.Int(i1)), (Types.TInt, Types.Int(i2)) -> (Types.TInt, Types.Int(i1 - i2))
          | _ -> Stdlib.failwith "bad subtraction types")
        | Ast.Mult -> (match left, right with
        | (Types.TInt, Types.Int(i1)), (Types.TInt, Types.Int(i2)) -> (Types.TInt, Types.Int(i1 * i2))
          | _ -> Stdlib.failwith "bad multiplication types")
        | Ast.Div -> (match left, right with
        | (Types.TInt, Types.Int(i1)), (Types.TInt, Types.Int(i2)) -> (Types.TInt, Types.Int(i1 / i2))
          | _ -> Stdlib.failwith "bad division types")
        | Ast.Eq -> (match left, right with
          | (Types.TInt, Types.Int(i1)), (Types.TInt, Types.Int(i2)) -> (Types.TBool, Types.Bool(i1 == i2))
          | (Types.TBool, Types.Bool(b1)), (Types.TBool, Types.Bool(b2)) -> (Types.TBool, Types.Bool(b1 == b2))
          | _ -> Stdlib.failwith "bad equality types")
  )
  | Ast.Int(i) -> (Types.TInt, Types.Int(i))
  | Ast.Bool(b) -> (Types.TBool, Types.Bool(b))
  (* | Ast.Unit -> (Types.TUnit, Types.Unit) *)
  | Ast.Call(func, a_params) -> (match (eval_expr scope func) with
    | Types.TAny, Types.Fun(f_params, ret, bod)
    | Types.TFun(_, _), Types.Fun(f_params, ret, bod) -> eval_func_call f_params (List.map (eval_expr scope) a_params) ret bod
    | t, _ -> Stdlib.failwith ("Type " ^ (Types.string_of_type t) ^ " is not callable."))
  | Ast.Name(name) -> (match lookup scope name with
    | t, e_opt -> (match e_opt with
      | Some e -> t, e
      | None -> Stdlib.failwith "Tried to evaluate uninitialized variable."))

and eval_func_call (f_params: (Types.typ * Ast.id) list) (a_params: (Types.typ * Types.obj) list) (ret: Types.typ) (bod: Ast.bod) : (Types.typ * Types.obj) = 
  (* would've been neat if I could've used `declare` and `initialize` (or simply `assign`), but the error messages... *)
  if (List.compare_lengths f_params a_params) != 0 then Stdlib.failwith "arguments length don't match parameters length"
  else (let scope: state list = [Hashtbl.create 1021] in
    let _ = List.iter2 (fun (decl_typ, name) (val_typ, value) -> 
      if Types.issubclass val_typ decl_typ then Hashtbl.add (List.hd scope) name (decl_typ, Some value)
      else Stdlib.failwith "Invalid argument type") f_params a_params in
      (* would've loved to use `exec_body`, but it would've added another state. this would allow `def foo(int x) -> str {str x = ""; return x;}` *)
      let stmt_value = (match bod with
      | Ast.Body(stmts) -> stream_take_until (stream_map (exec_stmt scope) (Stream.of_list stmts)) (fun x -> x != None)) in
        let return_val = (match stmt_value with
        | Some s_v -> (match s_v with
          | Continue l_o -> Stdlib.failwith "Continue outside of loop (in func)..."
          | Break l_o -> Stdlib.failwith "Break outside of loop (in func)..."
          | Return e -> e)
        | None -> Types.Unit) in
          let ret_v_type = Types.type_of_value return_val in
            if Types.issubclass ret_v_type ret then (ret, return_val)
            else Stdlib.failwith ("Function expected to return value of type " ^ Types.string_of_type ret ^ " but instead returned value of type " ^ Types.string_of_type ret_v_type))
    
(* and eval_func_call (f_params: (Types.typ * Ast.id) list) (a_params: (Types.typ * Types.obj) list) (ret: Types.typ) (bod: Ast.bod) : (Types.typ * Types.obj) = 
  (* would've been neat if I could've used `declare` and `initialize` (or simply `assign`), but the error messages... *)
  let scope: state list = [Hashtbl.create 1021] in
    let args = List.combine f_params a_params in
      let _ = List.iter (fun ((decl_typ, name), (val_typ, value)) -> 
        if Types.issubclass val_typ decl_typ then Hashtbl.add (List.hd scope) name (decl_typ, Some value)
        else Stdlib.failwith "Invalid argument type") args in
        (* would've loved to use `exec_body`, but it would've added another state. this would allow `def foo(int x) -> str {str x = ""; return x;}` *)
        let stmt_value = (match bod with
        | Ast.Body(stmts) -> stream_take_until (stream_map (exec_stmt scope) (Stream.of_list stmts)) (fun x -> x != None)) in
          let return_val = (match stmt_value with
          | Some s_v -> (match s_v with
            | Continue l_o -> Stdlib.failwith "Continue outside of loop (in func)..."
            | Break l_o -> Stdlib.failwith "Break outside of loop (in func)..."
            | Return e -> e)
          | None -> Types.Unit) in
            let ret_v_type = Types.type_of_value return_val in
              if Types.issubclass ret_v_type ret then (ret, return_val)
              else Stdlib.failwith ("Function expected to return value of type " ^ Types.string_of_type ret ^ " but instead returned value of type " ^ Types.string_of_type ret_v_type) *)

and exec_stmt (scope: state list) (_node: Ast.statement) : stmt_val =  
  match _node with
  | Ast.Assign(id, expr, typ) -> assign scope id (Option.map Types.type_of_string typ) (Option.map (eval_expr scope) expr)
  (* | Ast.Assign(id, expr, typ) -> exec_assign scope id typ expr *)
    (* (match typ with
    | Some t -> throw_away [declare scope id (type_of_string t); throw_away (print_string "asdlkfjdasklfj"); throw_away (print_state (List.hd scope));
    (match expr with   (* made this a list because of a type warning *)
      | Some e -> let t, e = eval_expr scope e in initialize scope id e t
      | None -> None)]
    | None -> (match expr with
      | Some e -> let t, e = eval_expr scope e in initialize scope id e t
      | None -> None)) *)
  | Ast.If(test, body, else_clause) -> let b = boolify (eval_expr scope test) in if b then exec_body scope body else exec_orelse scope else_clause
  | Ast.While(test, body, else_clause, label) -> exec_while_stmt scope test body else_clause label
  | Ast.Expr expr -> (throw_away (eval_expr scope expr))
  | Ast.Print v -> (match eval_expr scope v with
      | Types.TBool, obj
      | Types.TInt, obj -> throw_away (print_endline (Types.string_of_value obj))
      | t, _ -> Stdlib.failwith (Types.string_of_type t))
  | Ast.Break label -> Some (Break label)
  | Ast.Continue label -> Some (Continue label)
  | Ast.Return e -> Some (Return (match Option.map (eval_expr scope) e with
    | Some(t, v) -> v
    | None -> Types.Unit))
  | Ast.FunctionDef(name, params, ret, bod) -> let params = List.map (fun (t_name, id) -> (Types.type_of_string t_name, id)) params and ret = Types.type_of_string ret in
    let e = Types.Fun(params, ret, bod) in
      let t = Types.type_of_value e in
        assign scope name (Some t) (Some(t, e))
and exec_while_stmt (scope: state list) (test: Ast.expr) (body: Ast.bod) (else_clause: Ast.or_else option) (label: Ast.id option) : stmt_val = 
  (match boolify (eval_expr scope test) with
    | true -> 
      let e = (exec_body scope body) in
        (match e with
        | Some (b_c_r) -> (match b_c_r with
          | Break e_lbl -> (match e_lbl with
            | None -> None
            | Some e_lbl_name -> (match label with
              | Some label_name -> 
                (if (String.equal label_name e_lbl_name) then None else e)
              | None -> e)
            )
          | Continue e_lbl -> (match e_lbl with
            | None -> (exec_while_stmt scope test body else_clause label)
            | Some e_lbl_name -> (match label with
              | Some label_name ->
                (if (String.equal label_name e_lbl_name) then (exec_while_stmt scope test body else_clause label) else e)
              | None -> e)
            )
          | Return return_val -> e
          )
        | None -> (exec_while_stmt scope test body else_clause label))
    | false -> exec_orelse scope else_clause)
and exec_body (scope: state list) (_node: Ast.bod) : stmt_val = 
  let scope = add_env scope in
    match _node with
    | Ast.Body stmts -> stream_take_until (stream_map (exec_stmt scope) (Stream.of_list stmts)) (fun x -> x != None)

and exec_orelse (scope: state list) (_node: Ast.or_else option) : stmt_val = 
  match _node with
  | None -> None
  | Some Ast.OrElse bod -> exec_body scope bod

and exec_f (scope: state list) (_node: Ast.f) : stmt_val =
  match _node with
  | Ast.File bod -> (let e = exec_body scope bod in (
    match e with
    | Some bc -> raise (Stdlib.Failure (match bc with
      | Break lbl -> (match lbl with
        | Some lbl_name -> ("no loop with label \"" ^ lbl_name ^ "\" outside of break stmt")
        | None -> "break outside of loop" )
      | Continue lbl -> (match lbl with
        | Some lbl_name -> ("no loop with label \"" ^ lbl_name ^ "\" outside of continue stmt")
        | None -> "continue outside of loop")
      | Return e -> Stdlib.failwith "return outside of function definition? wack"
    ))
    | None -> None)
  )
