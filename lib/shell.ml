
(* https://caml.inria.fr/pub/docs/manual-ocaml/libref/Sys.html *)

let hello () =
  Cgi.w "🌺 At first check if we really have no commandline arguments.";
  let argc = Array.length Sys.argv in
    for i = 0 to argc - 1 do
      Printf.printf "[%i] '%s'\n" i Sys.argv.(i)
    done;
  let cwd = Sys.getcwd () in
    Cgi.w cwd;
  let prg = Sys.executable_name in
    Cgi.w prg;
 (* printf "cwd: '%s'\n" Sys.getcwd (); *)
  0

(* TODO: have a closer look at
 * https://v1.realworldocaml.org/v1/en/html/error-handling.html#encoding-errors-with-result
 *)
type myfe =
  | Feed  of Syndic.Atom.feed
  | Error of string list

let load_or_create_feed_file f =
  match Sys.file_exists f with
    | false -> Error [f; "No such file or directory"]
      (* http://cumulus.github.io/Syndic/syndic/Syndic__/Syndic_atom/index.html#val-read *)
    | true  -> Feed (Syndic.Atom.read f)

  (* load *)
  (* if fails
   *   create new only if file doesn't exist *)

let run_argc0 exe =
  let name = String.concat Filename.dir_sep ["app"; "var"; "o.atom"] in
  let sep = ": " in
  match load_or_create_feed_file name with
    | Feed  (f) ->
      begin match f.title with
        | Text (t) ->
          prerr_endline t;
          0
        | _ -> 
          let lst = [exe; "das kommt jetzt etwas überraschend."] in
          let msg = String.concat sep lst in
          prerr_endline msg;
          3
      end
    | Error (e) ->
      let lst = List.cons exe e in
      let msg = String.concat sep lst in
      prerr_endline msg;
      1
 
let run () =
  let exe = Filename.basename Sys.executable_name in
  let sep = ": " in
  match Array.length Sys.argv with
    | 1 ->
      run_argc0 exe
    | _ -> 
      let lst = [exe; "I don't accept commandline parameters"] in
      let msg = String.concat sep lst in
      prerr_endline msg;
      2

