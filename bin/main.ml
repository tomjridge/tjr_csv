(* read stdin and reformat *)


open Yojson.Safe

let (insep,outsep) = 
  if (Array.length Sys.argv >= 2) then
    let arg = Sys.argv.(1) in
    arg 
    |> Yojson.Safe.from_string 
    |> function `List [`String insep;`String outsep] -> (insep,outsep)
  else (",","|")
[@@warning "-8"]

(* assume these are single chars *)
let insep_char,outsep_char = 
  assert(String.length insep = 1 && String.length outsep = 1);
  (insep.[0],outsep.[0])

open Tjr_csv

let read_stream ic =
  1024 |> fun len ->
  let buf = Bytes.create len in
  let rec f sofar last_nread = 
    if last_nread = 0 then sofar else
      input ic buf 0 len |> fun nread ->
      let sofar=sofar^(Bytes.sub_string buf 0 nread) in
      f sofar nread
  in
  f "" (-99) |> fun s ->
  close_in ic;
  s[@@warning "-3"]

let dq = "\""
let dq_char = '\"'
let nl = '\n'

let needs_quote s = 
  let contains = String.contains s in
  contains outsep_char || contains dq_char || contains nl 

let quote s = 
  s 
  |> Tjr_string.explode
  |> List.map (String.make 1)
  |> List.map (fun s -> if s=dq then dq^dq else s)
  |> Tjr_string.concat_strings ~sep:""
  |> fun s -> dq^s^dq

(* FIXME may get an extra empty line? *)
let main () = 
  read_stream Pervasives.stdin |> fun s ->
  rows s |> function Some(rows,_) ->
  rows |> 
  List.iter (fun row ->
      let dest_field = function `Quoted s -> s | `Unquoted s -> s in
      row
      |> List.map (fun f ->
        dest_field f |> fun s -> if needs_quote s then quote s else s)
      |> Tjr_string.concat_strings ~sep:outsep
      |> print_endline)[@@warning "-8"]

let _ = main ()
