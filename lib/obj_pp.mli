val repr : Obj.t -> PPrint.document

val magic : 'a -> PPrint.document

val print : ?channel:out_channel -> ?width:int -> Obj.t -> unit

val pp : ?width:int -> unit -> Format.formatter -> Obj.t -> unit

val to_string : ?width:int -> Obj.t -> string

val print_magic : ?channel:out_channel -> ?width:int -> 'a -> unit

val pp_magic : ?width:int -> unit -> Format.formatter -> 'a -> unit

val to_string_magic : ?width:int -> 'a -> string
