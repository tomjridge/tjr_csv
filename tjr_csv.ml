open P0

(* csv -------------------------------------------------------------- *)

let dq = "\""
let comma = ","
let eol = "\n"
let rec inside sofar s = (
  upto_a dq -- a dq |>> fun (x,_) ->
  (opt (a dq) |>> function
    | None -> return (`Quoted (sofar^x))
    | Some _ -> inside (sofar^x^dq))) s
let quoted = (a dq -- inside "") |>> fun (_,x) -> return x
let unquoted_terminators = ("["^comma^dq^eol^"]")
(* NOTE the following will parse an empty line as an unquoted *)
let unquoted s = (
  upto_re unquoted_terminators |>> fun x -> return (`Unquoted x)) s
let field = quoted || unquoted
let row = plus ~sep:(a comma) field  (* see unquoted || (a"" |>> fun _ -> return []) *)
let rows = star ~sep:(a eol) row

