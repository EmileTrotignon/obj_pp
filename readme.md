# obj_pp

This is a little library capable of printing any OCaml value.

It work by printing the memory representation as given by the module `Obj`.
Use it at your own peril, I do not know what I am doing ! It might segfault,
although it did not on my machine.

Tested with OCaml 5.1, it should not be too hard to port it to other version,
but its probably harder to make it work with all a range of OCaml versions.