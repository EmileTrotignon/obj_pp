let () = Obj_pp.print_magic [4; 5; 6; 7]

let () = Obj_pp.print_magic (4, (5, (6, 7)))

let () = Obj_pp.print_magic [|4; 5; 6; 7|]

type adt = Int of int | Float of float | Cons of string * adt * adt

let my_adt =
  Cons ("second string", Cons ("first string", Int 12, Float 1.2), Float 1.4)

let my_adt = Cons ("more !", my_adt, my_adt)

let my_adt = Cons ("more !", my_adt, my_adt)

let my_adt = Cons ("more !", my_adt, my_adt)

let _f () x = x + 14

let () =
  let _x = 27 in
  Obj_pp.print_magic (_x, _f)

let () =
  let _x = 27 in
  let g y = _f () _x + y in
  Obj_pp.print_magic g

let () = Obj_pp.print_magic my_adt

let () = Obj_pp.print_magic None

let () = Obj_pp.print_magic [|1.2; 1.4; 1.6; 1.9|]
