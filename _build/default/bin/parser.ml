
module MenhirBasics = struct
  
  exception Error
  
  let _eRR =
    fun _s ->
      raise Error
  
  type token = 
    | TRUE
    | TNULL
    | TINT
    | TBOOL
    | TANY
    | SEMICOLON
    | RPAREN
    | PRINT
    | PLUS
    | NULL
    | MULTIPLY
    | MINUS
    | LPAREN
    | INT of (
# 4 "bin/parser.mly"
       (int)
# 28 "bin/parser.ml"
  )
    | ID of (
# 5 "bin/parser.mly"
       (string)
# 33 "bin/parser.ml"
  )
    | FALSE
    | EQUALS
    | EQEQ
    | EOF
    | DIVIDE
    | COLON
  
end

include MenhirBasics

# 1 "bin/parser.mly"
  
    open Ast

# 50 "bin/parser.ml"

type ('s, 'r) _menhir_state = 
  | MenhirState00 : ('s, _menhir_box_main) _menhir_state
    (** State 00.
        Stack shape : .
        Start symbol: main. *)

  | MenhirState02 : (('s, _menhir_box_main) _menhir_cell1_PRINT, _menhir_box_main) _menhir_state
    (** State 02.
        Stack shape : PRINT.
        Start symbol: main. *)

  | MenhirState04 : (('s, _menhir_box_main) _menhir_cell1_LPAREN, _menhir_box_main) _menhir_state
    (** State 04.
        Stack shape : LPAREN.
        Start symbol: main. *)

  | MenhirState10 : (('s, _menhir_box_main) _menhir_cell1_expr _menhir_cell0_PLUS, _menhir_box_main) _menhir_state
    (** State 10.
        Stack shape : expr PLUS.
        Start symbol: main. *)

  | MenhirState12 : (('s, _menhir_box_main) _menhir_cell1_expr _menhir_cell0_MULTIPLY, _menhir_box_main) _menhir_state
    (** State 12.
        Stack shape : expr MULTIPLY.
        Start symbol: main. *)

  | MenhirState15 : (('s, _menhir_box_main) _menhir_cell1_expr _menhir_cell0_DIVIDE, _menhir_box_main) _menhir_state
    (** State 15.
        Stack shape : expr DIVIDE.
        Start symbol: main. *)

  | MenhirState17 : (('s, _menhir_box_main) _menhir_cell1_expr _menhir_cell0_MINUS, _menhir_box_main) _menhir_state
    (** State 17.
        Stack shape : expr MINUS.
        Start symbol: main. *)

  | MenhirState19 : (('s, _menhir_box_main) _menhir_cell1_expr _menhir_cell0_EQEQ, _menhir_box_main) _menhir_state
    (** State 19.
        Stack shape : expr EQEQ.
        Start symbol: main. *)

  | MenhirState25 : (('s, _menhir_box_main) _menhir_cell1_statement, _menhir_box_main) _menhir_state
    (** State 25.
        Stack shape : statement.
        Start symbol: main. *)

  | MenhirState30 : (('s, _menhir_box_main) _menhir_cell1_name, _menhir_box_main) _menhir_state
    (** State 30.
        Stack shape : name.
        Start symbol: main. *)

  | MenhirState38 : (('s, _menhir_box_main) _menhir_cell1_name _menhir_cell0_typ, _menhir_box_main) _menhir_state
    (** State 38.
        Stack shape : name typ.
        Start symbol: main. *)


and ('s, 'r) _menhir_cell1_expr = 
  | MenhirCell1_expr of 's * ('s, 'r) _menhir_state * (Ast.expr) * Lexing.position * Lexing.position

and ('s, 'r) _menhir_cell1_name = 
  | MenhirCell1_name of 's * ('s, 'r) _menhir_state * (Ast.name) * Lexing.position

and ('s, 'r) _menhir_cell1_statement = 
  | MenhirCell1_statement of 's * ('s, 'r) _menhir_state * (Ast.statement)

and 's _menhir_cell0_typ = 
  | MenhirCell0_typ of 's * (Ast.typ) * Lexing.position

and 's _menhir_cell0_DIVIDE = 
  | MenhirCell0_DIVIDE of 's * Lexing.position * Lexing.position

and 's _menhir_cell0_EQEQ = 
  | MenhirCell0_EQEQ of 's * Lexing.position * Lexing.position

and ('s, 'r) _menhir_cell1_LPAREN = 
  | MenhirCell1_LPAREN of 's * ('s, 'r) _menhir_state * Lexing.position

and 's _menhir_cell0_MINUS = 
  | MenhirCell0_MINUS of 's * Lexing.position * Lexing.position

and 's _menhir_cell0_MULTIPLY = 
  | MenhirCell0_MULTIPLY of 's * Lexing.position * Lexing.position

and 's _menhir_cell0_PLUS = 
  | MenhirCell0_PLUS of 's * Lexing.position * Lexing.position

and ('s, 'r) _menhir_cell1_PRINT = 
  | MenhirCell1_PRINT of 's * ('s, 'r) _menhir_state * Lexing.position

and _menhir_box_main = 
  | MenhirBox_main of (Ast.file) [@@unboxed]

let _menhir_action_01 =
  fun _endpos_t_ _startpos_target_ t target ->
    let _endpos = _endpos_t_ in
    let _startpos = _startpos_target_ in
    let _loc = (_startpos, _endpos) in
    (
# 109 "bin/parser.mly"
                                                                            ( Assign(target, None, Some t, _loc) )
# 153 "bin/parser.ml"
     : (Ast.statement))

let _menhir_action_02 =
  fun _endpos_e_ _startpos_target_ e target ->
    let _endpos = _endpos_e_ in
    let _startpos = _startpos_target_ in
    let _loc = (_startpos, _endpos) in
    (
# 110 "bin/parser.mly"
                                                                            ( Assign(target, Some e, None, _loc) )
# 164 "bin/parser.ml"
     : (Ast.statement))

let _menhir_action_03 =
  fun _endpos_e_ _startpos_target_ e t target ->
    let _endpos = _endpos_e_ in
    let _startpos = _startpos_target_ in
    let _loc = (_startpos, _endpos) in
    (
# 111 "bin/parser.mly"
                                                                            ( Assign(target, Some e, Some t, _loc) )
# 175 "bin/parser.ml"
     : (Ast.statement))

let _menhir_action_04 =
  fun _endpos_i_ _startpos_i_ i ->
    let _endpos = _endpos_i_ in
    let _startpos = _startpos_i_ in
    let _loc = (_startpos, _endpos) in
    (
# 124 "bin/parser.mly"
                                    ( Int(i, _loc) )
# 186 "bin/parser.ml"
     : (Ast.expr))

let _menhir_action_05 =
  fun _endpos__1_ _startpos__1_ ->
    let _endpos = _endpos__1_ in
    let _startpos = _startpos__1_ in
    let _loc = (_startpos, _endpos) in
    (
# 125 "bin/parser.mly"
                                    ( Bool(true, _loc) )
# 197 "bin/parser.ml"
     : (Ast.expr))

let _menhir_action_06 =
  fun _endpos__1_ _startpos__1_ ->
    let _endpos = _endpos__1_ in
    let _startpos = _startpos__1_ in
    let _loc = (_startpos, _endpos) in
    (
# 126 "bin/parser.mly"
                                    ( Bool(false, _loc) )
# 208 "bin/parser.ml"
     : (Ast.expr))

let _menhir_action_07 =
  fun _endpos__1_ _startpos__1_ ->
    let _endpos = _endpos__1_ in
    let _startpos = _startpos__1_ in
    let _loc = (_startpos, _endpos) in
    (
# 127 "bin/parser.mly"
                                    ( None(_loc) )
# 219 "bin/parser.ml"
     : (Ast.expr))

let _menhir_action_08 =
  fun _endpos_id_ _startpos_id_ id ->
    let _endpos = _endpos_id_ in
    let _startpos = _startpos_id_ in
    let _loc = (_startpos, _endpos) in
    (
# 128 "bin/parser.mly"
                                    ( Var(id, _loc) )
# 230 "bin/parser.ml"
     : (Ast.expr))

let _menhir_action_09 =
  fun _1 _endpos__1_ _endpos_e2_ _startpos__1_ _startpos_e1_ e1 e2 ->
    let op =
      let _endpos = _endpos__1_ in
      let _startpos = _startpos__1_ in
      let _loc = (_startpos, _endpos) in
      
# 138 "bin/parser.mly"
                                    ( Plus(_loc) )
# 242 "bin/parser.ml"
      
    in
    let _endpos = _endpos_e2_ in
    let _startpos = _startpos_e1_ in
    let _loc = (_startpos, _endpos) in
    (
# 132 "bin/parser.mly"
                                    ( BinaryOp(op, e1, e2, _loc) )
# 251 "bin/parser.ml"
     : (Ast.expr))

let _menhir_action_10 =
  fun _1 _endpos__1_ _endpos_e2_ _startpos__1_ _startpos_e1_ e1 e2 ->
    let op =
      let _endpos = _endpos__1_ in
      let _startpos = _startpos__1_ in
      let _loc = (_startpos, _endpos) in
      
# 139 "bin/parser.mly"
                                    ( Minus(_loc) )
# 263 "bin/parser.ml"
      
    in
    let _endpos = _endpos_e2_ in
    let _startpos = _startpos_e1_ in
    let _loc = (_startpos, _endpos) in
    (
# 132 "bin/parser.mly"
                                    ( BinaryOp(op, e1, e2, _loc) )
# 272 "bin/parser.ml"
     : (Ast.expr))

let _menhir_action_11 =
  fun _1 _endpos__1_ _endpos_e2_ _startpos__1_ _startpos_e1_ e1 e2 ->
    let op =
      let _endpos = _endpos__1_ in
      let _startpos = _startpos__1_ in
      let _loc = (_startpos, _endpos) in
      
# 140 "bin/parser.mly"
                                    ( Mult(_loc) )
# 284 "bin/parser.ml"
      
    in
    let _endpos = _endpos_e2_ in
    let _startpos = _startpos_e1_ in
    let _loc = (_startpos, _endpos) in
    (
# 132 "bin/parser.mly"
                                    ( BinaryOp(op, e1, e2, _loc) )
# 293 "bin/parser.ml"
     : (Ast.expr))

let _menhir_action_12 =
  fun _1 _endpos__1_ _endpos_e2_ _startpos__1_ _startpos_e1_ e1 e2 ->
    let op =
      let _endpos = _endpos__1_ in
      let _startpos = _startpos__1_ in
      let _loc = (_startpos, _endpos) in
      
# 141 "bin/parser.mly"
                                    ( Div(_loc) )
# 305 "bin/parser.ml"
      
    in
    let _endpos = _endpos_e2_ in
    let _startpos = _startpos_e1_ in
    let _loc = (_startpos, _endpos) in
    (
# 132 "bin/parser.mly"
                                    ( BinaryOp(op, e1, e2, _loc) )
# 314 "bin/parser.ml"
     : (Ast.expr))

let _menhir_action_13 =
  fun _1 _endpos__1_ _endpos_e2_ _startpos__1_ _startpos_e1_ e1 e2 ->
    let op =
      let _endpos = _endpos__1_ in
      let _startpos = _startpos__1_ in
      let _loc = (_startpos, _endpos) in
      
# 142 "bin/parser.mly"
                                    ( Eq(_loc) )
# 326 "bin/parser.ml"
      
    in
    let _endpos = _endpos_e2_ in
    let _startpos = _startpos_e1_ in
    let _loc = (_startpos, _endpos) in
    (
# 132 "bin/parser.mly"
                                    ( BinaryOp(op, e1, e2, _loc) )
# 335 "bin/parser.ml"
     : (Ast.expr))

let _menhir_action_14 =
  fun e ->
    (
# 133 "bin/parser.mly"
                                    ( e )
# 343 "bin/parser.ml"
     : (Ast.expr))

let _menhir_action_15 =
  fun a ->
    (
# 134 "bin/parser.mly"
                                    ( a )
# 351 "bin/parser.ml"
     : (Ast.expr))

let _menhir_action_16 =
  fun () ->
    (
# 208 "<standard.mly>"
    ( [] )
# 359 "bin/parser.ml"
     : (Ast.statement list))

let _menhir_action_17 =
  fun x xs ->
    (
# 210 "<standard.mly>"
    ( x :: xs )
# 367 "bin/parser.ml"
     : (Ast.statement list))

let _menhir_action_18 =
  fun body ->
    (
# 48 "bin/parser.mly"
                                                                            ( Module(body) )
# 375 "bin/parser.ml"
     : (Ast.file))

let _menhir_action_19 =
  fun _endpos_n_ _startpos_n_ n ->
    let _endpos = _endpos_n_ in
    let _startpos = _startpos_n_ in
    let _loc = (_startpos, _endpos) in
    (
# 121 "bin/parser.mly"
                                    ( (n, _loc) )
# 386 "bin/parser.ml"
     : (Ast.name))

let _menhir_action_20 =
  fun _endpos_e_ _startpos__1_ e ->
    let _endpos = _endpos_e_ in
    let _startpos = _startpos__1_ in
    let _loc = (_startpos, _endpos) in
    (
# 72 "bin/parser.mly"
                                                                            ( Print(e, _loc) )
# 397 "bin/parser.ml"
     : (Ast.statement))

let _menhir_action_21 =
  fun a ->
    (
# 67 "bin/parser.mly"
                                                                            ( a )
# 405 "bin/parser.ml"
     : (Ast.statement))

let _menhir_action_22 =
  fun _endpos_e_ _startpos_e_ e ->
    let _endpos = _endpos_e_ in
    let _startpos = _startpos_e_ in
    let _loc = (_startpos, _endpos) in
    (
# 68 "bin/parser.mly"
                                                                            ( Expr(e, _loc) )
# 416 "bin/parser.ml"
     : (Ast.statement))

let _menhir_action_23 =
  fun p ->
    (
# 69 "bin/parser.mly"
                                                                            ( p )
# 424 "bin/parser.ml"
     : (Ast.statement))

let _menhir_action_24 =
  fun s ->
    (
# 58 "bin/parser.mly"
                                                                            ( s )
# 432 "bin/parser.ml"
     : (Ast.statement))

let _menhir_action_25 =
  fun body ->
    (
# 51 "bin/parser.mly"
                                                                            ( Body(body) )
# 440 "bin/parser.ml"
     : (Ast.bod))

let _menhir_action_26 =
  fun _endpos__1_ _startpos__1_ ->
    let _endpos = _endpos__1_ in
    let _startpos = _startpos__1_ in
    let _loc = (_startpos, _endpos) in
    (
# 114 "bin/parser.mly"
                                        ( TBool(_loc) )
# 451 "bin/parser.ml"
     : (Ast.typ))

let _menhir_action_27 =
  fun _endpos__1_ _startpos__1_ ->
    let _endpos = _endpos__1_ in
    let _startpos = _startpos__1_ in
    let _loc = (_startpos, _endpos) in
    (
# 115 "bin/parser.mly"
                                        ( TInt(_loc) )
# 462 "bin/parser.ml"
     : (Ast.typ))

let _menhir_action_28 =
  fun _endpos__1_ _startpos__1_ ->
    let _endpos = _endpos__1_ in
    let _startpos = _startpos__1_ in
    let _loc = (_startpos, _endpos) in
    (
# 116 "bin/parser.mly"
                                        ( TAny(_loc) )
# 473 "bin/parser.ml"
     : (Ast.typ))

let _menhir_action_29 =
  fun _endpos__1_ _startpos__1_ ->
    let _endpos = _endpos__1_ in
    let _startpos = _startpos__1_ in
    let _loc = (_startpos, _endpos) in
    (
# 117 "bin/parser.mly"
                                        ( TNull(_loc) )
# 484 "bin/parser.ml"
     : (Ast.typ))

let _menhir_print_token : token -> string =
  fun _tok ->
    match _tok with
    | COLON ->
        "COLON"
    | DIVIDE ->
        "DIVIDE"
    | EOF ->
        "EOF"
    | EQEQ ->
        "EQEQ"
    | EQUALS ->
        "EQUALS"
    | FALSE ->
        "FALSE"
    | ID _ ->
        "ID"
    | INT _ ->
        "INT"
    | LPAREN ->
        "LPAREN"
    | MINUS ->
        "MINUS"
    | MULTIPLY ->
        "MULTIPLY"
    | NULL ->
        "NULL"
    | PLUS ->
        "PLUS"
    | PRINT ->
        "PRINT"
    | RPAREN ->
        "RPAREN"
    | SEMICOLON ->
        "SEMICOLON"
    | TANY ->
        "TANY"
    | TBOOL ->
        "TBOOL"
    | TINT ->
        "TINT"
    | TNULL ->
        "TNULL"
    | TRUE ->
        "TRUE"

let _menhir_fail : unit -> 'a =
  fun () ->
    Printf.eprintf "Internal failure -- please contact the parser generator's developers.\n%!";
    assert false

include struct
  
  [@@@ocaml.warning "-4-37-39"]
  
  let rec _menhir_run_44_spec_00 : type  ttv_stack. ttv_stack -> _ -> _menhir_box_main =
    fun _menhir_stack _v ->
      let _v =
        let body = _v in
        _menhir_action_25 body
      in
      let body = _v in
      let _v = _menhir_action_18 body in
      MenhirBox_main _v
  
  let rec _menhir_run_40 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_statement -> _ -> _menhir_box_main =
    fun _menhir_stack _v ->
      let MenhirCell1_statement (_menhir_stack, _menhir_s, x) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_17 x xs in
      _menhir_goto_list_statement_ _menhir_stack _v _menhir_s
  
  and _menhir_goto_list_statement_ : type  ttv_stack. ttv_stack -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _v _menhir_s ->
      match _menhir_s with
      | MenhirState00 ->
          _menhir_run_44_spec_00 _menhir_stack _v
      | MenhirState25 ->
          _menhir_run_40 _menhir_stack _v
      | _ ->
          _menhir_fail ()
  
  let rec _menhir_run_41 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_10 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MULTIPLY ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_12 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_19 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIVIDE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_15 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SEMICOLON ->
          let (_endpos_e_, _startpos_e_, e) = (_endpos, _startpos, _v) in
          let _v = _menhir_action_22 _endpos_e_ _startpos_e_ e in
          _menhir_goto_simpl_stmt _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_10 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_expr -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
      let _menhir_stack = MenhirCell0_PLUS (_menhir_stack, _startpos, _endpos) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          let _startpos_0 = _menhir_lexbuf.Lexing.lex_start_p in
          let _endpos_1 = _menhir_lexbuf.Lexing.lex_curr_p in
          let _tok = _menhir_lexer _menhir_lexbuf in
          let (_endpos__1_, _startpos__1_) = (_endpos_1, _startpos_0) in
          let _v = _menhir_action_05 _endpos__1_ _startpos__1_ in
          _menhir_run_14_spec_10 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__1_ _startpos__1_ _v _tok
      | NULL ->
          let _startpos_2 = _menhir_lexbuf.Lexing.lex_start_p in
          let _endpos_3 = _menhir_lexbuf.Lexing.lex_curr_p in
          let _tok = _menhir_lexer _menhir_lexbuf in
          let (_endpos__1_, _startpos__1_) = (_endpos_3, _startpos_2) in
          let _v = _menhir_action_07 _endpos__1_ _startpos__1_ in
          _menhir_run_14_spec_10 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__1_ _startpos__1_ _v _tok
      | LPAREN ->
          _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState10
      | INT _v ->
          let _startpos_4 = _menhir_lexbuf.Lexing.lex_start_p in
          let _endpos_5 = _menhir_lexbuf.Lexing.lex_curr_p in
          let _tok = _menhir_lexer _menhir_lexbuf in
          let (_endpos_i_, _startpos_i_, i) = (_endpos_5, _startpos_4, _v) in
          let _v = _menhir_action_04 _endpos_i_ _startpos_i_ i in
          _menhir_run_14_spec_10 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_i_ _startpos_i_ _v _tok
      | ID _v ->
          let _startpos_6 = _menhir_lexbuf.Lexing.lex_start_p in
          let _endpos_7 = _menhir_lexbuf.Lexing.lex_curr_p in
          let _tok = _menhir_lexer _menhir_lexbuf in
          let (_endpos_id_, _startpos_id_, id) = (_endpos_7, _startpos_6, _v) in
          let _v = _menhir_action_08 _endpos_id_ _startpos_id_ id in
          _menhir_run_14_spec_10 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_id_ _startpos_id_ _v _tok
      | FALSE ->
          let _startpos_8 = _menhir_lexbuf.Lexing.lex_start_p in
          let _endpos_9 = _menhir_lexbuf.Lexing.lex_curr_p in
          let _tok = _menhir_lexer _menhir_lexbuf in
          let (_endpos__1_, _startpos__1_) = (_endpos_9, _startpos_8) in
          let _v = _menhir_action_06 _endpos__1_ _startpos__1_ in
          _menhir_run_14_spec_10 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__1_ _startpos__1_ _v _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_14_spec_10 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_expr _menhir_cell0_PLUS -> _ -> _ -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _tok ->
      let (_endpos_a_, _startpos_a_, a) = (_endpos, _startpos, _v) in
      let _v = _menhir_action_15 a in
      _menhir_run_11 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_a_ _startpos_a_ _v MenhirState10 _tok
  
  and _menhir_run_11 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_expr _menhir_cell0_PLUS as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | MULTIPLY ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_12 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIVIDE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_15 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQEQ | MINUS | PLUS | RPAREN | SEMICOLON ->
          let MenhirCell0_PLUS (_menhir_stack, _startpos__1_, _endpos__1_) = _menhir_stack in
          let MenhirCell1_expr (_menhir_stack, _menhir_s, e1, _startpos_e1_, _) = _menhir_stack in
          let (_1, _endpos_e2_, e2) = ((), _endpos, _v) in
          let _v = _menhir_action_09 _1 _endpos__1_ _endpos_e2_ _startpos__1_ _startpos_e1_ e1 e2 in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_e2_ _startpos_e1_ _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_12 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_expr -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
      let _menhir_stack = MenhirCell0_MULTIPLY (_menhir_stack, _startpos, _endpos) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          let _startpos_0 = _menhir_lexbuf.Lexing.lex_start_p in
          let _endpos_1 = _menhir_lexbuf.Lexing.lex_curr_p in
          let _tok = _menhir_lexer _menhir_lexbuf in
          let (_endpos__1_, _startpos__1_) = (_endpos_1, _startpos_0) in
          let _v = _menhir_action_05 _endpos__1_ _startpos__1_ in
          _menhir_run_14_spec_12 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__1_ _v _tok
      | NULL ->
          let _startpos_2 = _menhir_lexbuf.Lexing.lex_start_p in
          let _endpos_3 = _menhir_lexbuf.Lexing.lex_curr_p in
          let _tok = _menhir_lexer _menhir_lexbuf in
          let (_endpos__1_, _startpos__1_) = (_endpos_3, _startpos_2) in
          let _v = _menhir_action_07 _endpos__1_ _startpos__1_ in
          _menhir_run_14_spec_12 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__1_ _v _tok
      | LPAREN ->
          _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState12
      | INT _v ->
          let _startpos_4 = _menhir_lexbuf.Lexing.lex_start_p in
          let _endpos_5 = _menhir_lexbuf.Lexing.lex_curr_p in
          let _tok = _menhir_lexer _menhir_lexbuf in
          let (_endpos_i_, _startpos_i_, i) = (_endpos_5, _startpos_4, _v) in
          let _v = _menhir_action_04 _endpos_i_ _startpos_i_ i in
          _menhir_run_14_spec_12 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_i_ _v _tok
      | ID _v ->
          let _startpos_6 = _menhir_lexbuf.Lexing.lex_start_p in
          let _endpos_7 = _menhir_lexbuf.Lexing.lex_curr_p in
          let _tok = _menhir_lexer _menhir_lexbuf in
          let (_endpos_id_, _startpos_id_, id) = (_endpos_7, _startpos_6, _v) in
          let _v = _menhir_action_08 _endpos_id_ _startpos_id_ id in
          _menhir_run_14_spec_12 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_id_ _v _tok
      | FALSE ->
          let _startpos_8 = _menhir_lexbuf.Lexing.lex_start_p in
          let _endpos_9 = _menhir_lexbuf.Lexing.lex_curr_p in
          let _tok = _menhir_lexer _menhir_lexbuf in
          let (_endpos__1_, _startpos__1_) = (_endpos_9, _startpos_8) in
          let _v = _menhir_action_06 _endpos__1_ _startpos__1_ in
          _menhir_run_14_spec_12 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__1_ _v _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_14_spec_12 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_expr _menhir_cell0_MULTIPLY -> _ -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _tok ->
      let (_endpos_a_, a) = (_endpos, _v) in
      let _v = _menhir_action_15 a in
      _menhir_run_13 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_a_ _v _tok
  
  and _menhir_run_13 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_expr _menhir_cell0_MULTIPLY -> _ -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _tok ->
      let MenhirCell0_MULTIPLY (_menhir_stack, _startpos__1_, _endpos__1_) = _menhir_stack in
      let MenhirCell1_expr (_menhir_stack, _menhir_s, e1, _startpos_e1_, _) = _menhir_stack in
      let (_1, _endpos_e2_, e2) = ((), _endpos, _v) in
      let _v = _menhir_action_11 _1 _endpos__1_ _endpos_e2_ _startpos__1_ _startpos_e1_ e1 e2 in
      _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_e2_ _startpos_e1_ _v _menhir_s _tok
  
  and _menhir_goto_expr : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState00 ->
          _menhir_run_41 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState25 ->
          _menhir_run_41 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState38 ->
          _menhir_run_39 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState30 ->
          _menhir_run_31 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState02 ->
          _menhir_run_21 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState19 ->
          _menhir_run_20 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState17 ->
          _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState15 ->
          _menhir_run_16 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _tok
      | MenhirState12 ->
          _menhir_run_13 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _tok
      | MenhirState10 ->
          _menhir_run_11 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState04 ->
          _menhir_run_08 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
  
  and _menhir_run_39 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_name _menhir_cell0_typ as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_10 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MULTIPLY ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_12 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_19 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIVIDE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_15 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SEMICOLON ->
          let MenhirCell0_typ (_menhir_stack, t, _) = _menhir_stack in
          let MenhirCell1_name (_menhir_stack, _menhir_s, target, _startpos_target_) = _menhir_stack in
          let (_endpos_e_, e) = (_endpos, _v) in
          let _v = _menhir_action_03 _endpos_e_ _startpos_target_ e t target in
          _menhir_goto_assignment _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_17 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_expr -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
      let _menhir_stack = MenhirCell0_MINUS (_menhir_stack, _startpos, _endpos) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          let _startpos_0 = _menhir_lexbuf.Lexing.lex_start_p in
          let _endpos_1 = _menhir_lexbuf.Lexing.lex_curr_p in
          let _tok = _menhir_lexer _menhir_lexbuf in
          let (_endpos__1_, _startpos__1_) = (_endpos_1, _startpos_0) in
          let _v = _menhir_action_05 _endpos__1_ _startpos__1_ in
          _menhir_run_14_spec_17 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__1_ _startpos__1_ _v _tok
      | NULL ->
          let _startpos_2 = _menhir_lexbuf.Lexing.lex_start_p in
          let _endpos_3 = _menhir_lexbuf.Lexing.lex_curr_p in
          let _tok = _menhir_lexer _menhir_lexbuf in
          let (_endpos__1_, _startpos__1_) = (_endpos_3, _startpos_2) in
          let _v = _menhir_action_07 _endpos__1_ _startpos__1_ in
          _menhir_run_14_spec_17 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__1_ _startpos__1_ _v _tok
      | LPAREN ->
          _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState17
      | INT _v ->
          let _startpos_4 = _menhir_lexbuf.Lexing.lex_start_p in
          let _endpos_5 = _menhir_lexbuf.Lexing.lex_curr_p in
          let _tok = _menhir_lexer _menhir_lexbuf in
          let (_endpos_i_, _startpos_i_, i) = (_endpos_5, _startpos_4, _v) in
          let _v = _menhir_action_04 _endpos_i_ _startpos_i_ i in
          _menhir_run_14_spec_17 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_i_ _startpos_i_ _v _tok
      | ID _v ->
          let _startpos_6 = _menhir_lexbuf.Lexing.lex_start_p in
          let _endpos_7 = _menhir_lexbuf.Lexing.lex_curr_p in
          let _tok = _menhir_lexer _menhir_lexbuf in
          let (_endpos_id_, _startpos_id_, id) = (_endpos_7, _startpos_6, _v) in
          let _v = _menhir_action_08 _endpos_id_ _startpos_id_ id in
          _menhir_run_14_spec_17 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_id_ _startpos_id_ _v _tok
      | FALSE ->
          let _startpos_8 = _menhir_lexbuf.Lexing.lex_start_p in
          let _endpos_9 = _menhir_lexbuf.Lexing.lex_curr_p in
          let _tok = _menhir_lexer _menhir_lexbuf in
          let (_endpos__1_, _startpos__1_) = (_endpos_9, _startpos_8) in
          let _v = _menhir_action_06 _endpos__1_ _startpos__1_ in
          _menhir_run_14_spec_17 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__1_ _startpos__1_ _v _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_14_spec_17 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_expr _menhir_cell0_MINUS -> _ -> _ -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _tok ->
      let (_endpos_a_, _startpos_a_, a) = (_endpos, _startpos, _v) in
      let _v = _menhir_action_15 a in
      _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_a_ _startpos_a_ _v MenhirState17 _tok
  
  and _menhir_run_18 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_expr _menhir_cell0_MINUS as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | MULTIPLY ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_12 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIVIDE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_15 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQEQ | MINUS | PLUS | RPAREN | SEMICOLON ->
          let MenhirCell0_MINUS (_menhir_stack, _startpos__1_, _endpos__1_) = _menhir_stack in
          let MenhirCell1_expr (_menhir_stack, _menhir_s, e1, _startpos_e1_, _) = _menhir_stack in
          let (_1, _endpos_e2_, e2) = ((), _endpos, _v) in
          let _v = _menhir_action_10 _1 _endpos__1_ _endpos_e2_ _startpos__1_ _startpos_e1_ e1 e2 in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_e2_ _startpos_e1_ _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_15 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_expr -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
      let _menhir_stack = MenhirCell0_DIVIDE (_menhir_stack, _startpos, _endpos) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          let _startpos_0 = _menhir_lexbuf.Lexing.lex_start_p in
          let _endpos_1 = _menhir_lexbuf.Lexing.lex_curr_p in
          let _tok = _menhir_lexer _menhir_lexbuf in
          let (_endpos__1_, _startpos__1_) = (_endpos_1, _startpos_0) in
          let _v = _menhir_action_05 _endpos__1_ _startpos__1_ in
          _menhir_run_14_spec_15 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__1_ _v _tok
      | NULL ->
          let _startpos_2 = _menhir_lexbuf.Lexing.lex_start_p in
          let _endpos_3 = _menhir_lexbuf.Lexing.lex_curr_p in
          let _tok = _menhir_lexer _menhir_lexbuf in
          let (_endpos__1_, _startpos__1_) = (_endpos_3, _startpos_2) in
          let _v = _menhir_action_07 _endpos__1_ _startpos__1_ in
          _menhir_run_14_spec_15 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__1_ _v _tok
      | LPAREN ->
          _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState15
      | INT _v ->
          let _startpos_4 = _menhir_lexbuf.Lexing.lex_start_p in
          let _endpos_5 = _menhir_lexbuf.Lexing.lex_curr_p in
          let _tok = _menhir_lexer _menhir_lexbuf in
          let (_endpos_i_, _startpos_i_, i) = (_endpos_5, _startpos_4, _v) in
          let _v = _menhir_action_04 _endpos_i_ _startpos_i_ i in
          _menhir_run_14_spec_15 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_i_ _v _tok
      | ID _v ->
          let _startpos_6 = _menhir_lexbuf.Lexing.lex_start_p in
          let _endpos_7 = _menhir_lexbuf.Lexing.lex_curr_p in
          let _tok = _menhir_lexer _menhir_lexbuf in
          let (_endpos_id_, _startpos_id_, id) = (_endpos_7, _startpos_6, _v) in
          let _v = _menhir_action_08 _endpos_id_ _startpos_id_ id in
          _menhir_run_14_spec_15 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_id_ _v _tok
      | FALSE ->
          let _startpos_8 = _menhir_lexbuf.Lexing.lex_start_p in
          let _endpos_9 = _menhir_lexbuf.Lexing.lex_curr_p in
          let _tok = _menhir_lexer _menhir_lexbuf in
          let (_endpos__1_, _startpos__1_) = (_endpos_9, _startpos_8) in
          let _v = _menhir_action_06 _endpos__1_ _startpos__1_ in
          _menhir_run_14_spec_15 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__1_ _v _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_14_spec_15 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_expr _menhir_cell0_DIVIDE -> _ -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _tok ->
      let (_endpos_a_, a) = (_endpos, _v) in
      let _v = _menhir_action_15 a in
      _menhir_run_16 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_a_ _v _tok
  
  and _menhir_run_16 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_expr _menhir_cell0_DIVIDE -> _ -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _tok ->
      let MenhirCell0_DIVIDE (_menhir_stack, _startpos__1_, _endpos__1_) = _menhir_stack in
      let MenhirCell1_expr (_menhir_stack, _menhir_s, e1, _startpos_e1_, _) = _menhir_stack in
      let (_1, _endpos_e2_, e2) = ((), _endpos, _v) in
      let _v = _menhir_action_12 _1 _endpos__1_ _endpos_e2_ _startpos__1_ _startpos_e1_ e1 e2 in
      _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_e2_ _startpos_e1_ _v _menhir_s _tok
  
  and _menhir_run_04 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _menhir_stack = MenhirCell1_LPAREN (_menhir_stack, _menhir_s, _startpos) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          let _startpos_0 = _menhir_lexbuf.Lexing.lex_start_p in
          let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
          let _tok = _menhir_lexer _menhir_lexbuf in
          let (_endpos__1_, _startpos__1_) = (_endpos, _startpos_0) in
          let _v = _menhir_action_05 _endpos__1_ _startpos__1_ in
          _menhir_run_14_spec_04 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__1_ _startpos__1_ _v _tok
      | NULL ->
          let _startpos_1 = _menhir_lexbuf.Lexing.lex_start_p in
          let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
          let _tok = _menhir_lexer _menhir_lexbuf in
          let (_endpos__1_, _startpos__1_) = (_endpos, _startpos_1) in
          let _v = _menhir_action_07 _endpos__1_ _startpos__1_ in
          _menhir_run_14_spec_04 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__1_ _startpos__1_ _v _tok
      | LPAREN ->
          _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState04
      | INT _v ->
          let _startpos_2 = _menhir_lexbuf.Lexing.lex_start_p in
          let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
          let _tok = _menhir_lexer _menhir_lexbuf in
          let (_endpos_i_, _startpos_i_, i) = (_endpos, _startpos_2, _v) in
          let _v = _menhir_action_04 _endpos_i_ _startpos_i_ i in
          _menhir_run_14_spec_04 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_i_ _startpos_i_ _v _tok
      | ID _v ->
          let _startpos_3 = _menhir_lexbuf.Lexing.lex_start_p in
          let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
          let _tok = _menhir_lexer _menhir_lexbuf in
          let (_endpos_id_, _startpos_id_, id) = (_endpos, _startpos_3, _v) in
          let _v = _menhir_action_08 _endpos_id_ _startpos_id_ id in
          _menhir_run_14_spec_04 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_id_ _startpos_id_ _v _tok
      | FALSE ->
          let _startpos_4 = _menhir_lexbuf.Lexing.lex_start_p in
          let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
          let _tok = _menhir_lexer _menhir_lexbuf in
          let (_endpos__1_, _startpos__1_) = (_endpos, _startpos_4) in
          let _v = _menhir_action_06 _endpos__1_ _startpos__1_ in
          _menhir_run_14_spec_04 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__1_ _startpos__1_ _v _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_14_spec_04 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_LPAREN -> _ -> _ -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _tok ->
      let (_endpos_a_, _startpos_a_, a) = (_endpos, _startpos, _v) in
      let _v = _menhir_action_15 a in
      _menhir_run_08 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_a_ _startpos_a_ _v MenhirState04 _tok
  
  and _menhir_run_08 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_LPAREN as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | RPAREN ->
          let _endpos_0 = _menhir_lexbuf.Lexing.lex_curr_p in
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_LPAREN (_menhir_stack, _menhir_s, _startpos__1_) = _menhir_stack in
          let (e, _endpos__3_) = (_v, _endpos_0) in
          let _v = _menhir_action_14 e in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__3_ _startpos__1_ _v _menhir_s _tok
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_10 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MULTIPLY ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_12 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_19 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIVIDE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_15 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _eRR ()
  
  and _menhir_run_19 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_expr -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
      let _menhir_stack = MenhirCell0_EQEQ (_menhir_stack, _startpos, _endpos) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          let _startpos_0 = _menhir_lexbuf.Lexing.lex_start_p in
          let _endpos_1 = _menhir_lexbuf.Lexing.lex_curr_p in
          let _tok = _menhir_lexer _menhir_lexbuf in
          let (_endpos__1_, _startpos__1_) = (_endpos_1, _startpos_0) in
          let _v = _menhir_action_05 _endpos__1_ _startpos__1_ in
          _menhir_run_14_spec_19 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__1_ _startpos__1_ _v _tok
      | NULL ->
          let _startpos_2 = _menhir_lexbuf.Lexing.lex_start_p in
          let _endpos_3 = _menhir_lexbuf.Lexing.lex_curr_p in
          let _tok = _menhir_lexer _menhir_lexbuf in
          let (_endpos__1_, _startpos__1_) = (_endpos_3, _startpos_2) in
          let _v = _menhir_action_07 _endpos__1_ _startpos__1_ in
          _menhir_run_14_spec_19 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__1_ _startpos__1_ _v _tok
      | LPAREN ->
          _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState19
      | INT _v ->
          let _startpos_4 = _menhir_lexbuf.Lexing.lex_start_p in
          let _endpos_5 = _menhir_lexbuf.Lexing.lex_curr_p in
          let _tok = _menhir_lexer _menhir_lexbuf in
          let (_endpos_i_, _startpos_i_, i) = (_endpos_5, _startpos_4, _v) in
          let _v = _menhir_action_04 _endpos_i_ _startpos_i_ i in
          _menhir_run_14_spec_19 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_i_ _startpos_i_ _v _tok
      | ID _v ->
          let _startpos_6 = _menhir_lexbuf.Lexing.lex_start_p in
          let _endpos_7 = _menhir_lexbuf.Lexing.lex_curr_p in
          let _tok = _menhir_lexer _menhir_lexbuf in
          let (_endpos_id_, _startpos_id_, id) = (_endpos_7, _startpos_6, _v) in
          let _v = _menhir_action_08 _endpos_id_ _startpos_id_ id in
          _menhir_run_14_spec_19 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_id_ _startpos_id_ _v _tok
      | FALSE ->
          let _startpos_8 = _menhir_lexbuf.Lexing.lex_start_p in
          let _endpos_9 = _menhir_lexbuf.Lexing.lex_curr_p in
          let _tok = _menhir_lexer _menhir_lexbuf in
          let (_endpos__1_, _startpos__1_) = (_endpos_9, _startpos_8) in
          let _v = _menhir_action_06 _endpos__1_ _startpos__1_ in
          _menhir_run_14_spec_19 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__1_ _startpos__1_ _v _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_14_spec_19 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_expr _menhir_cell0_EQEQ -> _ -> _ -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _tok ->
      let (_endpos_a_, _startpos_a_, a) = (_endpos, _startpos, _v) in
      let _v = _menhir_action_15 a in
      _menhir_run_20 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_a_ _startpos_a_ _v MenhirState19 _tok
  
  and _menhir_run_20 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_expr _menhir_cell0_EQEQ as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_10 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MULTIPLY ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_12 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIVIDE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_15 _menhir_stack _menhir_lexbuf _menhir_lexer
      | RPAREN | SEMICOLON ->
          let MenhirCell0_EQEQ (_menhir_stack, _startpos__1_, _endpos__1_) = _menhir_stack in
          let MenhirCell1_expr (_menhir_stack, _menhir_s, e1, _startpos_e1_, _) = _menhir_stack in
          let (_1, _endpos_e2_, e2) = ((), _endpos, _v) in
          let _v = _menhir_action_13 _1 _endpos__1_ _endpos_e2_ _startpos__1_ _startpos_e1_ e1 e2 in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_e2_ _startpos_e1_ _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_goto_assignment : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let a = _v in
      let _v = _menhir_action_21 a in
      _menhir_goto_simpl_stmt _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
  
  and _menhir_goto_simpl_stmt : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let s = _v in
      let _v = _menhir_action_24 s in
      let _menhir_stack = MenhirCell1_statement (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
          let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
          let _tok = _menhir_lexer _menhir_lexbuf in
          let (_endpos__1_, _startpos__1_) = (_endpos, _startpos) in
          let _v = _menhir_action_05 _endpos__1_ _startpos__1_ in
          _menhir_run_14_spec_25 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__1_ _startpos__1_ _v _tok
      | PRINT ->
          _menhir_run_02 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState25
      | NULL ->
          let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
          let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
          let _tok = _menhir_lexer _menhir_lexbuf in
          let (_endpos__1_, _startpos__1_) = (_endpos, _startpos) in
          let _v = _menhir_action_07 _endpos__1_ _startpos__1_ in
          _menhir_run_14_spec_25 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__1_ _startpos__1_ _v _tok
      | LPAREN ->
          _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState25
      | INT _v_2 ->
          let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
          let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
          let _tok = _menhir_lexer _menhir_lexbuf in
          let (_endpos_i_, _startpos_i_, i) = (_endpos, _startpos, _v_2) in
          let _v = _menhir_action_04 _endpos_i_ _startpos_i_ i in
          _menhir_run_14_spec_25 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_i_ _startpos_i_ _v _tok
      | ID _v_4 ->
          _menhir_run_22 _menhir_stack _menhir_lexbuf _menhir_lexer _v_4 MenhirState25
      | FALSE ->
          let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
          let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
          let _tok = _menhir_lexer _menhir_lexbuf in
          let (_endpos__1_, _startpos__1_) = (_endpos, _startpos) in
          let _v = _menhir_action_06 _endpos__1_ _startpos__1_ in
          _menhir_run_14_spec_25 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__1_ _startpos__1_ _v _tok
      | EOF ->
          let _v = _menhir_action_16 () in
          _menhir_run_40 _menhir_stack _v
      | _ ->
          _eRR ()
  
  and _menhir_run_14_spec_25 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_statement -> _ -> _ -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _tok ->
      let (_endpos_a_, _startpos_a_, a) = (_endpos, _startpos, _v) in
      let _v = _menhir_action_15 a in
      _menhir_run_41 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_a_ _startpos_a_ _v MenhirState25 _tok
  
  and _menhir_run_02 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _menhir_stack = MenhirCell1_PRINT (_menhir_stack, _menhir_s, _startpos) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          let _startpos_0 = _menhir_lexbuf.Lexing.lex_start_p in
          let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
          let _tok = _menhir_lexer _menhir_lexbuf in
          let (_endpos__1_, _startpos__1_) = (_endpos, _startpos_0) in
          let _v = _menhir_action_05 _endpos__1_ _startpos__1_ in
          _menhir_run_14_spec_02 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__1_ _startpos__1_ _v _tok
      | NULL ->
          let _startpos_1 = _menhir_lexbuf.Lexing.lex_start_p in
          let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
          let _tok = _menhir_lexer _menhir_lexbuf in
          let (_endpos__1_, _startpos__1_) = (_endpos, _startpos_1) in
          let _v = _menhir_action_07 _endpos__1_ _startpos__1_ in
          _menhir_run_14_spec_02 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__1_ _startpos__1_ _v _tok
      | LPAREN ->
          _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState02
      | INT _v ->
          let _startpos_2 = _menhir_lexbuf.Lexing.lex_start_p in
          let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
          let _tok = _menhir_lexer _menhir_lexbuf in
          let (_endpos_i_, _startpos_i_, i) = (_endpos, _startpos_2, _v) in
          let _v = _menhir_action_04 _endpos_i_ _startpos_i_ i in
          _menhir_run_14_spec_02 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_i_ _startpos_i_ _v _tok
      | ID _v ->
          let _startpos_3 = _menhir_lexbuf.Lexing.lex_start_p in
          let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
          let _tok = _menhir_lexer _menhir_lexbuf in
          let (_endpos_id_, _startpos_id_, id) = (_endpos, _startpos_3, _v) in
          let _v = _menhir_action_08 _endpos_id_ _startpos_id_ id in
          _menhir_run_14_spec_02 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_id_ _startpos_id_ _v _tok
      | FALSE ->
          let _startpos_4 = _menhir_lexbuf.Lexing.lex_start_p in
          let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
          let _tok = _menhir_lexer _menhir_lexbuf in
          let (_endpos__1_, _startpos__1_) = (_endpos, _startpos_4) in
          let _v = _menhir_action_06 _endpos__1_ _startpos__1_ in
          _menhir_run_14_spec_02 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__1_ _startpos__1_ _v _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_14_spec_02 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_PRINT -> _ -> _ -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _tok ->
      let (_endpos_a_, _startpos_a_, a) = (_endpos, _startpos, _v) in
      let _v = _menhir_action_15 a in
      _menhir_run_21 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_a_ _startpos_a_ _v MenhirState02 _tok
  
  and _menhir_run_21 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_PRINT as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_10 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MULTIPLY ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_12 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_19 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIVIDE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_15 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SEMICOLON ->
          let MenhirCell1_PRINT (_menhir_stack, _menhir_s, _startpos__1_) = _menhir_stack in
          let (_endpos_e_, e) = (_endpos, _v) in
          let _v = _menhir_action_20 _endpos_e_ _startpos__1_ e in
          let p = _v in
          let _v = _menhir_action_23 p in
          _menhir_goto_simpl_stmt _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_22 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | DIVIDE | EQEQ | MINUS | MULTIPLY | PLUS | SEMICOLON ->
          let (_endpos_id_, _startpos_id_, id) = (_endpos, _startpos, _v) in
          let _v = _menhir_action_08 _endpos_id_ _startpos_id_ id in
          let (_endpos, _startpos) = (_endpos_id_, _startpos_id_) in
          let (_endpos_a_, _startpos_a_, a) = (_endpos, _startpos, _v) in
          let _v = _menhir_action_15 a in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_a_ _startpos_a_ _v _menhir_s _tok
      | COLON | EQUALS ->
          let (_endpos_n_, _startpos_n_, n) = (_endpos, _startpos, _v) in
          let _v = _menhir_action_19 _endpos_n_ _startpos_n_ n in
          let _startpos = _startpos_n_ in
          let _menhir_stack = MenhirCell1_name (_menhir_stack, _menhir_s, _v, _startpos) in
          (match (_tok : MenhirBasics.token) with
          | EQUALS ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | TRUE ->
                  let _startpos_0 = _menhir_lexbuf.Lexing.lex_start_p in
                  let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  let (_endpos__1_, _startpos__1_) = (_endpos, _startpos_0) in
                  let _v = _menhir_action_05 _endpos__1_ _startpos__1_ in
                  _menhir_run_14_spec_30 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__1_ _startpos__1_ _v _tok
              | NULL ->
                  let _startpos_2 = _menhir_lexbuf.Lexing.lex_start_p in
                  let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  let (_endpos__1_, _startpos__1_) = (_endpos, _startpos_2) in
                  let _v = _menhir_action_07 _endpos__1_ _startpos__1_ in
                  _menhir_run_14_spec_30 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__1_ _startpos__1_ _v _tok
              | LPAREN ->
                  _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState30
              | INT _v_4 ->
                  let _startpos_5 = _menhir_lexbuf.Lexing.lex_start_p in
                  let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  let (_endpos_i_, _startpos_i_, i) = (_endpos, _startpos_5, _v_4) in
                  let _v = _menhir_action_04 _endpos_i_ _startpos_i_ i in
                  _menhir_run_14_spec_30 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_i_ _startpos_i_ _v _tok
              | ID _v_7 ->
                  let _startpos_8 = _menhir_lexbuf.Lexing.lex_start_p in
                  let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  let (_endpos_id_, _startpos_id_, id) = (_endpos, _startpos_8, _v_7) in
                  let _v = _menhir_action_08 _endpos_id_ _startpos_id_ id in
                  _menhir_run_14_spec_30 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_id_ _startpos_id_ _v _tok
              | FALSE ->
                  let _startpos_10 = _menhir_lexbuf.Lexing.lex_start_p in
                  let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  let (_endpos__1_, _startpos__1_) = (_endpos, _startpos_10) in
                  let _v = _menhir_action_06 _endpos__1_ _startpos__1_ in
                  _menhir_run_14_spec_30 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__1_ _startpos__1_ _v _tok
              | _ ->
                  _eRR ())
          | COLON ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | TNULL ->
                  let _startpos_12 = _menhir_lexbuf.Lexing.lex_start_p in
                  let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  let (_endpos__1_, _startpos__1_) = (_endpos, _startpos_12) in
                  let _v = _menhir_action_29 _endpos__1_ _startpos__1_ in
                  _menhir_goto_typ _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__1_ _v _tok
              | TINT ->
                  let _startpos_14 = _menhir_lexbuf.Lexing.lex_start_p in
                  let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  let (_endpos__1_, _startpos__1_) = (_endpos, _startpos_14) in
                  let _v = _menhir_action_27 _endpos__1_ _startpos__1_ in
                  _menhir_goto_typ _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__1_ _v _tok
              | TBOOL ->
                  let _startpos_16 = _menhir_lexbuf.Lexing.lex_start_p in
                  let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  let (_endpos__1_, _startpos__1_) = (_endpos, _startpos_16) in
                  let _v = _menhir_action_26 _endpos__1_ _startpos__1_ in
                  _menhir_goto_typ _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__1_ _v _tok
              | TANY ->
                  let _startpos_18 = _menhir_lexbuf.Lexing.lex_start_p in
                  let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  let (_endpos__1_, _startpos__1_) = (_endpos, _startpos_18) in
                  let _v = _menhir_action_28 _endpos__1_ _startpos__1_ in
                  _menhir_goto_typ _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__1_ _v _tok
              | _ ->
                  _eRR ())
          | _ ->
              _menhir_fail ())
      | _ ->
          _eRR ()
  
  and _menhir_run_14_spec_30 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_name -> _ -> _ -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _tok ->
      let (_endpos_a_, _startpos_a_, a) = (_endpos, _startpos, _v) in
      let _v = _menhir_action_15 a in
      _menhir_run_31 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_a_ _startpos_a_ _v MenhirState30 _tok
  
  and _menhir_run_31 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_name as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_10 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MULTIPLY ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_12 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_19 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIVIDE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_15 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SEMICOLON ->
          let MenhirCell1_name (_menhir_stack, _menhir_s, target, _startpos_target_) = _menhir_stack in
          let (_endpos_e_, e) = (_endpos, _v) in
          let _v = _menhir_action_02 _endpos_e_ _startpos_target_ e target in
          _menhir_goto_assignment _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_goto_typ : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_name -> _ -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _tok ->
      match (_tok : MenhirBasics.token) with
      | EQUALS ->
          let _menhir_stack = MenhirCell0_typ (_menhir_stack, _v, _endpos) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TRUE ->
              let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
              let _endpos_0 = _menhir_lexbuf.Lexing.lex_curr_p in
              let _tok = _menhir_lexer _menhir_lexbuf in
              let (_endpos__1_, _startpos__1_) = (_endpos_0, _startpos) in
              let _v = _menhir_action_05 _endpos__1_ _startpos__1_ in
              _menhir_run_14_spec_38 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__1_ _startpos__1_ _v _tok
          | NULL ->
              let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
              let _endpos_2 = _menhir_lexbuf.Lexing.lex_curr_p in
              let _tok = _menhir_lexer _menhir_lexbuf in
              let (_endpos__1_, _startpos__1_) = (_endpos_2, _startpos) in
              let _v = _menhir_action_07 _endpos__1_ _startpos__1_ in
              _menhir_run_14_spec_38 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__1_ _startpos__1_ _v _tok
          | LPAREN ->
              _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState38
          | INT _v_4 ->
              let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
              let _endpos_5 = _menhir_lexbuf.Lexing.lex_curr_p in
              let _tok = _menhir_lexer _menhir_lexbuf in
              let (_endpos_i_, _startpos_i_, i) = (_endpos_5, _startpos, _v_4) in
              let _v = _menhir_action_04 _endpos_i_ _startpos_i_ i in
              _menhir_run_14_spec_38 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_i_ _startpos_i_ _v _tok
          | ID _v_7 ->
              let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
              let _endpos_8 = _menhir_lexbuf.Lexing.lex_curr_p in
              let _tok = _menhir_lexer _menhir_lexbuf in
              let (_endpos_id_, _startpos_id_, id) = (_endpos_8, _startpos, _v_7) in
              let _v = _menhir_action_08 _endpos_id_ _startpos_id_ id in
              _menhir_run_14_spec_38 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_id_ _startpos_id_ _v _tok
          | FALSE ->
              let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
              let _endpos_10 = _menhir_lexbuf.Lexing.lex_curr_p in
              let _tok = _menhir_lexer _menhir_lexbuf in
              let (_endpos__1_, _startpos__1_) = (_endpos_10, _startpos) in
              let _v = _menhir_action_06 _endpos__1_ _startpos__1_ in
              _menhir_run_14_spec_38 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__1_ _startpos__1_ _v _tok
          | _ ->
              _eRR ())
      | SEMICOLON ->
          let MenhirCell1_name (_menhir_stack, _menhir_s, target, _startpos_target_) = _menhir_stack in
          let (_endpos_t_, t) = (_endpos, _v) in
          let _v = _menhir_action_01 _endpos_t_ _startpos_target_ t target in
          _menhir_goto_assignment _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_14_spec_38 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_name _menhir_cell0_typ -> _ -> _ -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _tok ->
      let (_endpos_a_, _startpos_a_, a) = (_endpos, _startpos, _v) in
      let _v = _menhir_action_15 a in
      _menhir_run_39 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_a_ _startpos_a_ _v MenhirState38 _tok
  
  let rec _menhir_run_14_spec_00 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _tok ->
      let (_endpos_a_, _startpos_a_, a) = (_endpos, _startpos, _v) in
      let _v = _menhir_action_15 a in
      _menhir_run_41 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_a_ _startpos_a_ _v MenhirState00 _tok
  
  let rec _menhir_run_00 : type  ttv_stack. ttv_stack -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
          let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
          let _tok = _menhir_lexer _menhir_lexbuf in
          let (_endpos__1_, _startpos__1_) = (_endpos, _startpos) in
          let _v = _menhir_action_05 _endpos__1_ _startpos__1_ in
          _menhir_run_14_spec_00 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__1_ _startpos__1_ _v _tok
      | PRINT ->
          _menhir_run_02 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState00
      | NULL ->
          let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
          let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
          let _tok = _menhir_lexer _menhir_lexbuf in
          let (_endpos__1_, _startpos__1_) = (_endpos, _startpos) in
          let _v = _menhir_action_07 _endpos__1_ _startpos__1_ in
          _menhir_run_14_spec_00 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__1_ _startpos__1_ _v _tok
      | LPAREN ->
          _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState00
      | INT _v ->
          let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
          let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
          let _tok = _menhir_lexer _menhir_lexbuf in
          let (_endpos_i_, _startpos_i_, i) = (_endpos, _startpos, _v) in
          let _v = _menhir_action_04 _endpos_i_ _startpos_i_ i in
          _menhir_run_14_spec_00 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_i_ _startpos_i_ _v _tok
      | ID _v ->
          _menhir_run_22 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState00
      | FALSE ->
          let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
          let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
          let _tok = _menhir_lexer _menhir_lexbuf in
          let (_endpos__1_, _startpos__1_) = (_endpos, _startpos) in
          let _v = _menhir_action_06 _endpos__1_ _startpos__1_ in
          _menhir_run_14_spec_00 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__1_ _startpos__1_ _v _tok
      | EOF ->
          let _v = _menhir_action_16 () in
          _menhir_run_44_spec_00 _menhir_stack _v
      | _ ->
          _eRR ()
  
end

let main =
  fun _menhir_lexer _menhir_lexbuf ->
    let _menhir_stack = () in
    let MenhirBox_main v = _menhir_run_00 _menhir_stack _menhir_lexbuf _menhir_lexer in
    v

# 143 "bin/parser.mly"
  
# 1458 "bin/parser.ml"
