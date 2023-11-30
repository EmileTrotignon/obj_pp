(lang dune 3.11)

(name obj_pp)

(generate_opam_files true)

(source
 (github EmileTrotignon/obj_pp))

(authors "Emile Trotignon")

(maintainers "Emile Trotignon")

(license MIT)

(documentation https://url/to/documentation)

(package
 (name obj_pp)
 (synopsis "Print anything !")
 (description
  "Prints the memory representation of a value. Be aware that I do not know what I am doing.")
 (depends ocaml dune pprint))
