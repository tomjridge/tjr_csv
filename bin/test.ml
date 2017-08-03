open Tjr_csv

let _ = 
  print_string "Testing csv parser...";
  rows {|
a,b,c
d,"e,f,g",h
i,"jk""l",
|} 
  |> fun res ->
  let expected  = Some
      ([[`Unquoted ""]; [`Unquoted "a"; `Unquoted "b"; `Unquoted "c"];
        [`Unquoted "d"; `Quoted "e,f,g"; `Unquoted "h"];
        [`Unquoted "i"; `Quoted "jk\"l"; `Unquoted ""]; [`Unquoted ""]],
       "")
  in
  assert(res=expected);
  print_endline "finished!"
