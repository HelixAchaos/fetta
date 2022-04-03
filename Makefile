all:
	ocamlc -c types.ml && ocamlc -c ast.ml && ocamllex lexer.mll && menhir parser.mly --infer && ocamlc -c parser.mli && ocamlc -c lexer.ml && ocamlc -c parser.ml && ocamlc -c basic.ml && ocamlc -o basic lexer.cmo parser.cmo basic.cmo ast.cmo types.cmo