(* open Types *)

type break_or_continue = 
| Break of Ast.id option
| Continue of Ast.id option

type stmt_val = break_or_continue option

let string_of_list (l: 'a list) (f: 'a -> string) : string = "[" ^ String.concat ", "(List.map f l) ^ "]"

let throw_away (x: 'a) : stmt_val = None

let rec stream_take_until (stream: 'a Stream.t) (stop_cond: 'a -> bool) : 'a = 
  try (let e = Stream.next stream in
    if stop_cond e then e else stream_take_until stream stop_cond
  )
  with Stream.Failure -> None

let stream_map f stream =
  let rec next i =
    try Some (f (Stream.next stream))
    with Stream.Failure -> None in
  Stream.from next
  
(* let boolify (x: 'a) : bool =
  match x with
  | Int(n) -> n != 0
  | Bool(b) -> b
  | _ -> false *)

(* https://stackoverflow.com/a/6750294 *)
(* let rec fold_until f p acc = function
| x :: xs when p x -> acc
| x :: xs -> fold_until f p (f acc x) xs
| [] -> acc

let accum_until_five =
    fold_until (fun acc x -> x + acc) (fun x -> x = 5) 0 *)



let rec lookup (scope: ((Ast.id, Ast.expr) Hashtbl.t) list) (name: Ast.id) : Ast.expr =
  match scope with
  | [] -> Stdlib.failwith ("Name(" ^ name ^ ") Not found")
  (* | x :: xs -> try (Hashtbl.find x name) with Not_found -> lookup xs name *)
  | x :: xs -> if Hashtbl.mem x name then Hashtbl.find x name else lookup xs name

let assign (scope: ((Ast.id, Ast.expr) Hashtbl.t) list) (name: Ast.id) (v: Ast.expr) : stmt_val = 
  throw_away (Hashtbl.add (List.hd scope) name v)

let pop_env (scope: ((Ast.id, Ast.expr) Hashtbl.t) list) : ((Ast.id, Ast.expr) Hashtbl.t) list = 
  match scope with
  | [] -> Stdlib.failwith "Tried to pop global??"
  | x :: xs -> xs

let add_env (scope: ((Ast.id, Ast.expr) Hashtbl.t) list) : ((Ast.id, Ast.expr) Hashtbl.t) list = 
  List.concat [[Hashtbl.create 1021]; scope]



(*  | `UnaryOp | `BinaryOp | `Name | `OrElse | `Ast.expr | `If *)

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
  | Ast.Name(v) -> v
  (* UnaryOp *)
and dump_label (label: Ast.id option) = 
  match label with
  | Some l -> l
  | None -> "None"
and dump_stmt (_node: Ast.statement) : string =
  match _node with
  | Ast.Assign(id, expr) -> "Assign(" ^ id ^ "," ^ dump_expr expr ^ ")"
  | Ast.If(test, body, else_clause) -> "If(" ^ dump_expr test ^ "," ^ dump_body body ^ "," ^ dump_orelse else_clause ^ ")"
  | Ast.While(test, body, else_clause, label) -> "While(" ^ dump_expr test ^ "," ^ dump_body body ^ "," ^ dump_orelse else_clause ^ "," ^ dump_label label ^ ")"
  | Ast.Expr expr -> "Ast.expr(" ^ dump_expr expr ^ ")"
  | Ast.Print expr -> "print(" ^ dump_expr expr ^ ")"
  | Ast.Break label -> "Break(" ^ dump_label label ^ ")"
  | Ast.Continue label -> "Continue(" ^ dump_label label ^ ")"
and dump_body (_node: Ast.bod) : string = 
  match _node with
  | Body stmts -> "Body(" ^ (string_of_list stmts dump_stmt) ^ ")"

and dump_orelse (_node: Ast.or_else option) : string = 
  match _node with
  | None -> ""
  | Some OrElse bod -> "OrElse(" ^ (dump_body bod) ^ ")"

and dump_f (_node: Ast.f) : string =
  match _node with
  | File bod -> "File(" ^ dump_body bod ^ ")"





let rec eval_expr (scope: ((Ast.id, Ast.expr) Hashtbl.t) list) (_node: Ast.expr) : Ast.expr =
  match _node with
  | Ast.BinaryOp(bop, left, right) -> (
    let left = eval_expr scope left in 
      let right = eval_expr scope right in
        match bop with
        | Ast.Plus -> (match left, right with
          | (Ast.Int(i1)), (Ast.Int(i2)) -> (Ast.Int(i1 + i2))
          | _ -> raise (Stdlib.Failure "bad addition types"))
        | Ast.Minus -> (match left, right with
          | (Ast.Int(i1)), (Ast.Int(i2)) -> (Ast.Int(i1 - i2))
          | _ -> raise (Stdlib.Failure "bad subtraction types"))
        | Ast.Mult -> (match left, right with
          | (Ast.Int(i1)), (Ast.Int(i2)) -> (Ast.Int(i1 * i2))
          | _ -> raise (Stdlib.Failure "bad multiplication types"))
        | Ast.Div -> (match left, right with
          | (Ast.Int(i1)), (Ast.Int(i2)) -> (Ast.Int(i1 / i2))
          | _ -> raise (Stdlib.Failure "bad division types"))
        | Ast.Eq -> (match left, right with
        | (Ast.Int(i1)), (Ast.Int(i2)) -> (Ast.Bool(i1 == i2))
        | (Ast.Bool(b1)), (Ast.Bool(b2)) -> (Ast.Bool(b1 == b2))
        | _ -> raise (Stdlib.Failure "bad equality types"))
  )
  | Ast.Int(i) -> Ast.Int(i)
  | Ast.Bool(b) -> Ast.Bool(b)
  | Ast.Name(name) -> lookup scope name



let rec exec_stmt (scope: ((Ast.id, Ast.expr) Hashtbl.t) list) (_node: Ast.statement) : stmt_val =  
  match _node with
  | Ast.Assign(id, expr) -> assign scope id (eval_expr scope expr)
  | Ast.If(test, body, else_clause) ->
    (match eval_expr scope test with
      | Ast.Bool(b) -> if b then exec_body scope body else exec_orelse scope else_clause
      | _ -> raise (Stdlib.Failure "test case is not a boolean"))
  (* | While(test, body, else_clause) -> <exec_while_stmt>; exec_stmt scope While(test, body, else_clause) *)
  | Ast.While(test, body, else_clause, label) -> exec_while_stmt scope test body else_clause label
  | Ast.Expr expr -> (throw_away (eval_expr scope expr))
  | Ast.Print v -> (match eval_expr scope v with
      | Ast.Bool(b) -> throw_away (print_endline (string_of_bool b))
      | Ast.Int(n) -> throw_away (print_endline (string_of_int n))
      | _ -> raise (Stdlib.Failure "not printable type"))
  | Ast.Break label -> Some (Break label)
  | Ast.Continue label -> Some (Continue label)
and exec_while_stmt (scope: ((Ast.id, Ast.expr) Hashtbl.t) list) (test: Ast.expr) (body: Ast.bod) (else_clause: Ast.or_else option) (label: Ast.id option) : stmt_val = 
  (match eval_expr scope test with
    | Ast.Bool(true) -> 
      let e = (exec_body scope body) in
        (match e with
        | Some (Break e_lbl) -> (match e_lbl with
          | None -> None
          | Some e_lbl_name -> (match label with
            | Some label_name -> 
              (if (String.equal label_name e_lbl_name) then None else e)
            | None -> e)
        )
        | Some (Continue e_lbl) -> (match e_lbl with
          | None -> (exec_while_stmt scope test body else_clause label)
          | Some e_lbl_name -> (match label with
            | Some label_name ->
              (if (String.equal label_name e_lbl_name) then (exec_while_stmt scope test body else_clause label) else e)
            | None -> e)
        )
        | _ -> (exec_while_stmt scope test body else_clause label))
    | Ast.Bool(false) -> exec_orelse scope else_clause
    | _ -> raise (Stdlib.Failure "test case is not a boolean"))
and exec_body (scope: ((Ast.id, Ast.expr) Hashtbl.t) list) (_node: Ast.bod) : stmt_val = 
  let scope = add_env scope in
    match _node with
    | Ast.Body stmts -> stream_take_until (stream_map (exec_stmt scope) (Stream.of_list stmts)) (fun x -> x != None)

and exec_orelse (scope: ((Ast.id, Ast.expr) Hashtbl.t) list) (_node: Ast.or_else option) : stmt_val = 
  match _node with
  | None -> None
  | Some Ast.OrElse bod -> exec_body scope bod

and exec_f (scope: ((Ast.id, Ast.expr) Hashtbl.t) list) (_node: Ast.f) : stmt_val =
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
    ))
    | None -> None)
  )

let parse (s: string) : Ast.f =
  let lexbuf = Lexing.from_string s in
    let ast = Parser.main Lexer.read lexbuf in
    ast

let read_whole_file filename =
  let ch = open_in filename in
  let s = really_input_string ch (in_channel_length ch) in
  close_in ch;
  s

(* 
let _ =
  print_string (dump_f (parse (read_whole_file "test.owo"))) *)

let _ =
  let globals: (Ast.id, Ast.expr) Hashtbl.t = Hashtbl.create 1021 in
    let scope: ((Ast.id, Ast.expr) Hashtbl.t) list = [globals] in
      exec_f scope (parse (read_whole_file "test.owo"))