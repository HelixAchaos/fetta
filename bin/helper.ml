let string_of_list ?(sep: string = ", ") (l: 'a list) (f: 'a -> string) : string = "[" ^ String.concat sep (List.map f l) ^ "]"