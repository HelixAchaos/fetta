%{
    open Ast
%}
%token <int> INT
%token <string> ID
// %token COMMA 
%token SEMICOLON COLON
%token PLUS MINUS MULTIPLY DIVIDE EQEQ
%token LPAREN RPAREN
%token EQUALS
%token TRUE FALSE
%token NULL
%token TINT TBOOL TANY TNULL
// %token LBRACE RBRACE
// %token IF ELIF ELSE
// %token DEF RETURN ARROW
// %token WHILE DOT
// %token BREAK CONTINUE
%token PRINT
// %token FOR IN
// %token EOL
%token EOF
// %right EQUALS           /* lowest precedence */
%nonassoc EQEQ
%left PLUS MINUS
%left MULTIPLY DIVIDE
// %nonassoc IN
// %nonassoc UMINUS        /* highest precedence */
// %left LPAREN
// %left DOT               
%start main             /* the entry point */
%type <Ast.file> main
%type <Ast.expr> expr
%type <Ast.statement> assignment
%type <Ast.statement> statement
// %type <Ast.bod> block
%type <Ast.bod> statements
// %type <Ast.statement> while_stmt
// %type <Ast.statement> if_stmt
// %type <Ast.statement> break_stmt
// %type <Ast.statement> continue_stmt
// %type <Ast.statement> func_stmt
// %type <Ast.statement> return_stmt
// %type <Ast.or_else> elif_stmt
// %type <Ast.or_else> else_block
%%
main:
    body=statements; EOF                                                    { Module(body) }
;
statements:
    | body=list(statement)                                                  { Body(body) }
;
statement:
    // | i=if_stmt                                                             { i }
    // | w=while_stmt                                                          { w }
    // | for_stmt                                                              {  }
    // | f=func_stmt                                                           { f }
    | s=simpl_stmt; SEMICOLON                                               { s }
;
// func_stmt:
//     | DEF; name=name; LPAREN; params=separated_list(COMMA, pair(name, name)); RPAREN; COLON; ret=name; body=block { FunctionDef(name, params, ret, body)}
// ;
simpl_stmt:
    // | b=break_stmt                                                          { b }
    // | c=continue_stmt                                                       { c }
    // | r=return_stmt                                                         { r }
    | a=assignment                                                          { a }
    | e=expr                                                                { Expr(e, ($symbolstartpos, $endpos)) }
    | p=print_stmt                                                          { p }
;
print_stmt:
    | PRINT; e=expr                                                         { Print(e, $loc) }
;
// return_stmt:
//     | RETURN; e=expr?                                                       { Return(e) }
// ;
// break_stmt:
//     // | BREAK                                                                 { Break (Label None) }
//     | BREAK; lbl=label?;                                                    { Break lbl }
// ;
// continue_stmt:
//     // | CONTINUE                                                              { Continue (Label None) }
//     | CONTINUE; lbl=label?;                                                 { Continue lbl }
// ;
// label:
//     | lbl_name=name;                                                        { Label(lbl_name) }
// ;
// while_stmt:                                                                 
//     | WHILE; test=expr; body=block; orelse=else_block?                      { While(test, body, orelse, None) }
//     | WHILE; DOT; lbl=label; test=expr; body=block; orelse=else_block?      { While(test, body, orelse, label) }
// ;
// if_stmt:
//     | IF; test=expr; body=block; orelse=elif_stmt;                          { If(test, body, Some orelse) }
//     | IF; test=expr; body=block;                                            { If(test, body, None) }
//     | IF; test=expr; body=block; orelse=else_block;                         { If(test, body, Some orelse) }
// ;
// elif_stmt:  
//     | ELIF; test=expr; body=block; orelse=elif_stmt;                        { OrElse(Body([If(test, body, Some orelse)])) }
//     | ELIF; test=expr; body=block;                                          { OrElse(Body([If(test, body, None)])) }
//     | ELIF; test=expr; body=block; orelse=else_block;                       { OrElse(Body([If(test, body, Some orelse)])) }
// ;
// else_block:
//     | ELSE; body=block                                                      { OrElse(body) }
// ;
// block:
//     | LBRACE; body=statements; RBRACE                                       { body }
// ;
assignment:
    | target=name; COLON; t=typ                                             { Assign(target, None, Some t, $loc) }
    | target=name; EQUALS; e=expr                                           { Assign(target, Some e, None, $loc) }
    | target=name; COLON; t=typ; EQUALS; e=expr                             { Assign(target, Some e, Some t, $loc) }
;
typ:
    | TBOOL                             { TBool($loc) }
    | TINT                              { TInt($loc) }
    | TANY                              { TAny($loc) }
    | TNULL                             { TNull($loc) }            
    // | a=separated_list(COMMA, typ); ARROW; b=typ           { TFun(a, b) }
;
name:
    | n=ID                          { (n, $loc) }
;
atom:
    | i=INT                         { Int(i, $loc) }
    | TRUE                          { Bool(true, $loc) }
    | FALSE                         { Bool(false, $loc) }
    | NULL                          { None($loc) }
    | id=ID                         { Var(id, $loc) }
;
expr:
    // | func=expr; LPAREN; params=separated_list(COMMA, expr); RPAREN { Call(func, params) } 
    | e1=expr; op=bop; e2=expr      { BinaryOp(op, e1, e2, $loc) }
    | LPAREN; e=expr; RPAREN        { e }
    | a=atom                        { a }
;
// use `let` when defining a "leaf"
let bop==
    | PLUS;                         { Plus($loc) }
    | MINUS;                        { Minus($loc) }
    | MULTIPLY;                     { Mult($loc) }
    | DIVIDE;                       { Div($loc) }
    | EQEQ;                         { Eq($loc) }
%%