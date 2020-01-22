
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

type myfe =
  | Feed  of int
  | Error of string list

let load_feed_file f =
  match Sys.file_exists f with
    true  -> Feed 12
  | false -> Error [f; "No such file or directory"]

  (* load *)
  (* if fails
   *   create new only if file doesn't exist *)

let run () =
  let name = String.concat Filename.dir_sep ["app"; "var"; "o.atom"] in
  match load_feed_file name with
      Feed  (f) ->
        print_int f;
        0
    | Error (e) ->
        let exe = Filename.basename Sys.executable_name in
        let lst = List.cons exe e in
        let msg = String.concat ": " lst in
          Printf.eprintf "%s\n" msg;
          1

