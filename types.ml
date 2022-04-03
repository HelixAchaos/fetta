exception Not_Implemented

module Id_Manager = struct
  let _id = ref 0
  let generate_id () : int = (incr _id; !_id)
end

class t_obj = object (self)
  val _id : 'a list = new t_int (Id_Manager.generate_id)
  method __eq__ self other = new t_bool (self#_id == other#_id)  (* consider comparing values *)
  method __str__ self = raise Not_Implemented
  method __add__ self other = raise Not_Implemented
  method __sub__ self other = raise Not_Implemented
  method __mul__ self other = raise Not_Implemented
  method __div__ self other = raise Not_Implemented
  method __lt__ self other = raise Not_Implemented
  method __gt__ self other = raise Not_Implemented
  method __lte__ self other = (self#__eq__ other) || (self#__lt__ other) 
  method __gte__ self other = (self#__eq__ other) || (self#__gt__ other)
  method __getitem__ self slice = raise Not_Implemented
end and t_bool (v: bool) = object (self)
  inherit t_obj
  val _b: bool = v
  method __eq__ self other = new t_bool (self#_id == other#_id || self#_b == other#_b)
  method __str__ self = new t_string (if self#_b then "True" else "False")
end and t_int (v: int) = object (self)
  inherit t_obj
  val _v: int = v
  method __eq__ self other = new t_bool (self#_id == other#_id || self#_v == other#_v)
  method __str__ self = new t_string (string_of_int self#_v)
  method __add__ self other = new t_int ((self#_v) + (other#_v))
  method __sub__ self other = new t_int (self#_v - other#_v)
  method __mul__ self other = new t_int (self#_v * other#_v)
  method __div__ self other = new t_int (self#_v / other#_v)
  method __lt__ self other = new t_bool (self#_v < other#_v)
  method __gt__ self other = new t_bool (self#_v > other#_v)
  (* method __lte__ self other *)
  (* method __gte__ self other *)
end and t_string (v: string) = object (self)
  inherit t_obj
  val _v: string = v
  method __eq__ self other = new t_bool (self#_id == other#_id || String.equal self#_v other#_v)
  method __str__ self = new t_string (self#_v)
  method __add__ self other = new t_string (self#_v ^ other#_v)
  method __mul__ self other = self ^ (__mul__ self (__sub__ other t_int(1)))
  method __lt__ self other = new t_bool ((String.compare self#_v other#_v) == -1)
  method __gt__ self other = new t_bool ((String.compare self#_v other#_v) == 1)
end and t_unit = object (self)
  inherit t_obj
  method __eq__ self other = new t_bool(self#_id == other#_id)
end


(* type lu_obj = {
  _type : lu_type
  data: {

  }
}

type lu_type = {
  _type : lu_type
  parent: lu_type (* should I put `lu_obj` as explicit parent or just assume everything is child of parent *)
  data : {
    
  }
}


let _bool = {
  _type : lu_type
  parent: [lu_type]
  data : {
    value: bool
    __str__: string  (* bool -> string *)
    constructor: make_bool
  }
}
and make_bool v = {
  _type : _bool
  data : {
    value: v
    __str__: string_of_bool v
  }
}

let _int = {
  _type : lu_type
  parent: [lu_type]
  data : {
    value: int
    __str__: string   (* int -> string *)
    __add__: _int -> _int -> _int
    __sub__: _int -> _int -> _int
    __mul__: _int -> _int -> _int
    __div__: _int -> _int -> _int
  }
}
and make_int v = {
  _type : _int
  data : {
    value: v
    __str__: string_of_int v
    __add__ x y: x + y 
    __sub__ x y: x - y 
    __mul__ x y: x * y 
    __div__ x y: x / y 
  }
} *)