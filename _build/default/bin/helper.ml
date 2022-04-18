let string_of_loc (p: Ast.text_pos) : string = match p with
| a, b -> Printf.sprintf "In file[%s, %s]: line_num[%d, %d]: bol[%d, %d]: cnum[%d, %d]" a.pos_fname b.pos_fname  a.pos_lnum  b.pos_lnum  a.pos_bol  b.pos_bol  a.pos_cnum  b.pos_cnum

let string_of_list ?(sep: string = ", ") (l: 'a list) (f: 'a -> string) : string = "[" ^ String.concat sep (List.map f l) ^ "]"

let rec string_n_times (s: string) (n: int) : string = match n with
| 0 -> ""
| n -> s ^ string_n_times s (n - 1)

(* make an error function that uses line number to print out line
ex:


File "bin/dumper.ml", line 31, characters 19-21:
31 |     in "Assign(" ^ id ^ "," ^ expr ^ "," ^ typ ^ ")")
                        ^^
Error: This expression has type
         Dune__exe.Ast.name = string * Dune__exe.Ast.text_pos
       but an expression was expected of type string

*)