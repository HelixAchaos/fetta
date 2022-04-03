%{
    open Ast
%}
%token <int> INT
%token <string> ID
// %token <float> FLOAT
// %token <string> STRING
// %token COMMA  COLON
%token SEMICOLON
%token PLUS MINUS MULTIPLY DIVIDE EQEQ
%token LPAREN RPAREN LBRACE RBRACE // LSQR RSQR
// %token SQUOTE DQUOTE
%token EQUALS DOT
// %token DEL
%token TRUE FALSE
// %token NULL
%token IF ELIF ELSE
%token WHILE // FOR
%token BREAK CONTINUE
%token PRINT
// %token IN
// %token EOL
%token EOF
// %right EQUALS           /* lowest precedence */
// %right IF ELSE
%nonassoc EQEQ
%left PLUS MINUS
%left MULTIPLY DIVIDE
// %nonassoc IN
// %nonassoc UMINUS        /* highest precedence */
// %left DOT               
%start main             /* the entry point */
%type <Ast.f> main
%type <Ast.expr> expr
%type <Ast.statement> assignment
%type <Ast.statement> statement
%type <Ast.bod> block
%type <Ast.bod> statements
%type <Ast.statement> while_stmt
%type <Ast.statement> if_stmt
%type <Ast.or_else> elif_stmt
%type <Ast.or_else> else_block
%%
main:
    body=statements; EOF                                                    { File(body) }
;
statements:
    | body=list(statement)                         { Body(body) }  // use :: notation for linked list. build statements as you go?
;
statement:
    | i=if_stmt                                                             { i }
    | w=while_stmt                                                          { w }
    | b=break_stmt; SEMICOLON                                               { b }
    | c=continue_stmt; SEMICOLON                                            { c }
    // | for_stmt                                                           {  }
    | a=assignment; SEMICOLON                                               { (a) }
    | e=expr; SEMICOLON                                                     { Expr(e) }
    | PRINT; e=expr; SEMICOLON                                              { Print(e) }
;
// for_stmt:
//     | FOR; target=ID; IN; iter=expr; COLON; body=block; orelse=else_block?  { For(target, iter, body, orelse) }
// ;
break_stmt:
    | BREAK                                                                 { Break None }
    | BREAK; label=ID;                                                      { Break (Some label) }
;
continue_stmt:
    | CONTINUE                                                              { Continue None }
    | CONTINUE; label=ID;                                                   { Continue (Some label) }
;
while_stmt:                                                                 
    | WHILE; test=expr; body=block; orelse=else_block?                      { While(test, body, orelse, None) }
    | WHILE; DOT; label=ID; test=expr; body=block; orelse=else_block?       { While(test, body, orelse, Some label) }
;
if_stmt:
    | IF; test=expr; body=block; orelse=elif_stmt;                          { If(test, body, Some orelse) }
    | IF; test=expr; body=block;                                            { If(test, body, None) }
    | IF; test=expr; body=block; orelse=else_block;                         { If(test, body, Some orelse) }
;
elif_stmt:  
    | ELIF; test=expr; body=block; orelse=elif_stmt;                        { OrElse(Body([If(test, body, Some orelse)])) }
    | ELIF; test=expr; body=block;                                          { OrElse(Body([If(test, body, None)])) }
    | ELIF; test=expr; body=block; orelse=else_block;                       { OrElse(Body([If(test, body, Some orelse)])) }
;
else_block:
    | ELSE; body=block                                                      { OrElse(body) }
;
block:
    | LBRACE; body=statements; RBRACE                                       { body }
;
assignment:
    | target=ID; EQUALS; e=expr                                             { Assign(target, e) }
;
// list:
//     | LSQR; elts=separated_list(COMMA, expr); RSQR                          { List(elts) }                       
;
// ids:
//     | elts=separated_list(COMMA, ID)                                        { Tuple(elts) }        
// ;

// use `let` when defining a "leaf"
let bop==
    | PLUS;                         { Plus }
    | MINUS;                        { Minus }
    | MULTIPLY;                     { Mult }
    | DIVIDE;                       { Div }
    | EQEQ;                         { Eq }

// uop:
//     | MINUS; e=expr; %prec UMINUS   { Unop(Usub, e) }

expr:
    | id=ID                         { Name(id) }
    | e1=expr; op=bop; e2=expr      { BinaryOp(op, e1, e2) }
    | LPAREN; e=expr; RPAREN        { e }
    | i=INT                         { Int(i) }
    | TRUE                          { Bool(true) }
    | FALSE                         { Bool(false) }
;
%%