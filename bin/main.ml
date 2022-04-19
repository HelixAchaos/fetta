let parse (s: string) : Ast.file =
  let lexbuf = Lexing.from_string s in
    let ast = Parser.main Lexer.read lexbuf in
    ast

let read_whole_file filename =
  let ch = open_in filename in
  let s = really_input_string ch (in_channel_length ch) in
  close_in ch;
  s


let _ =
  print_endline (Dumper.dump_f (parse (read_whole_file "bin/test.owo")))

(* let _ =
  let globals: Interpreter.state = Hashtbl.create 1021 in
    let scope: Interpreter.state list = [globals] in
      Interpreter.exec_f scope (parse (read_whole_file "bin/test.owo")) *)