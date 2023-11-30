open Obj
open PPrint

let ( ^-^ ) a b = a ^^ space ^^ b

let rec repr ?(hex = false) r =
  group
    ( if is_block r then
        let tag = tag r in
        if tag = string_tag then OCaml.string (obj r)
        else if tag = double_tag then OCaml.float (obj r)
        else if tag = double_array_tag then float_array r
        else if tag = out_of_heap_tag then !^"<out_of_heap>"
        else if tag = no_scan_tag then !^"<no_scan>"
        else if tag = abstract_tag then !^"<abstract>"
        else if tag = unaligned_tag then !^"<unaligned>"
        else if tag = closure_tag then
          (* I have no idea how safe this is, especially across versions *)
          closure r
        else if tag = lazy_tag then !^"<lazy>"
        else if tag = cont_tag then !^"<continuation>"
        else if tag = object_tag then !^"<object>"
        else if tag = infix_tag then !^"<infix>"
        else if tag = forward_tag then !^"<forward>"
        else if tag = custom_tag then !^"<custom>"
        else if tag = int_tag then !^"<int ?>"
        else group @@ OCaml.int tag ^^ nest 2 (space ^^ block r)
      else if is_int r then
        !^(Printf.sprintf (if hex then "%#x" else "%i") (obj r))
      else failwith "Value was neither a block nor an int." )

and closure r =
  let Closure.{arity; start_env= _} = Closure.info r in
  !^"<closure" ^^ OCaml.int arity
  ^-^ !^(Printf.sprintf "%#x" (Nativeint.to_int (raw_field r 0)))
  ^^ !^">"

and block arr =
  align
    ( braces @@ space
    ^^ ( List.init (size arr) Fun.id
       |> separate_map (break 0 ^^ semi ^^ space) (fun i -> repr (field arr i))
       )
    ^^ space )

and float_array r =
  let arr = obj r in
  align
  @@ braces
       ( bar
       ^-^ ( arr |> Array.to_list
           |> separate_map (break 0 ^^ semi ^^ space) OCaml.float )
       ^-^ bar )

let repr obj = repr obj

let magic alpha = alpha |> Obj.repr |> repr

let print ?(channel = stdout) ?(width = 120) r =
  r |> repr |> ToChannel.pretty 0.8 width channel ;
  print_newline ()

let pp ?(width = 120) () fmt r = r |> repr |> ToFormatter.pretty 0.8 width fmt

let to_string ?(width = 120) r =
  let buf = Buffer.create 256 in
  r |> repr |> ToBuffer.pretty 0.8 width buf ;
  Buffer.contents buf

let print_magic ?channel ?width alpha =
  alpha |> Obj.repr |> print ?channel ?width

let pp_magic ?width () fmt alpha = alpha |> Obj.repr |> pp ?width () fmt

let to_string_magic ?width alpha = alpha |> Obj.repr |> to_string ?width
