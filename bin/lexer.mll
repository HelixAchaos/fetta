{
    open Parser        (* The type token is defined in parser.mli *)
    (* open Lexing *)
    (* open Printf *)
    exception Eof
}

let digit = ['0'-'9']
let id = ['a'-'z' 'A'-'Z' '_']['a'-'z' 'A'-'Z' '_' '0'-'9']*


rule read = parse
    [' ' '\t' '\r'] { read lexbuf }     (* skip blanks *)
    | '\n'          { Lexing.new_line lexbuf; read lexbuf }
    | digit+ as num { INT(int_of_string num) }
    | '+'	    	{ PLUS }
    | '-'	    	{ MINUS }
    | '*'	    	{ MULTIPLY }
    | '/'	    	{ DIVIDE }
    | "=="       	{ EQEQ }
    | '('	    	{ LPAREN }
    | ')'	    	{ RPAREN }
    | '{'	    	{ LBRACE }
    | '}'	    	{ RBRACE }
    (* | '#'           { COMMENT } *)
    (* | '['           { LSQR } *)
    (* | ']'           { RSQR } *)
    (* | '\''	    	{ SQUOTE }
    | '"'	    	{ DQUOTE } *)
    | '='	    	{ EQUALS }
    | '.'       	{ DOT }
    | "def"         { DEF }
    | ','           { COMMA }
    (* | ':'           { COLON } *)
    | ';'           { SEMICOLON }
    (* | "del"         { DEL } *)
    (* | "in"          { IN } *)
    | "if"          { IF }
    | "elif"        { ELIF }
    | "else"        { ELSE }
    (* | "for"         { FOR } *)
    | "while"       { WHILE }
    | "break"       { BREAK }
    | "continue"    { CONTINUE }
    | "return"      { RETURN }
    | "print"       { PRINT }
    | "True"        { TRUE }
    | "False"       { FALSE }
    | "->"          { ARROW }
    (* | "None"        { NULL } *)
    | id as word    { ID word }
    | _ as c        {
                        let pos = lexbuf.Lexing.lex_curr_p in
                        Printf.printf "Error at line %d\n" pos.Lexing.pos_lnum;
                        Printf.printf "      at col %d\n" (pos.Lexing.pos_cnum-pos.Lexing.pos_bol);
                        Printf.printf "Unrecognized character: [%c]\n" c;
                        exit 1
                    }
    | eof           { EOF }