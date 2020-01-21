open Printf

let hello () =
  Cgi.w "🌺 At first check if we really have no commandline arguments.";
  let cwd = Sys.getcwd () in
    Cgi.w cwd;
  let prg = Sys.executable_name in
    Cgi.w prg;
  let argc = Array.length Sys.argv in
    for i = 0 to argc - 1 do
      printf "[%i] '%s'\n" i Sys.argv.(i)
    done;
  (* printf "cwd: '%s'\n" Sys.getcwd (); *)
  exit 0;;
