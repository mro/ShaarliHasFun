
(* https://github.com/rixed/ocaml-cgi/blob/master/cgi.ml#L169 *)
let safe_getenv ?default s =
  try
    Sys.getenv s
  with Not_found ->
    match default with
    | Some d -> d
    | None ->
      failwith ("Cgi: the environment variable " ^ s ^ " is not set")

(* https://docs.mirage.io/uri/Uri/ *)

let w s = 
  print_string s;
  print_string "\n"

let va n =
  print_string "<li>";
  print_string n;
  print_string ": ";
  let v = safe_getenv ~default:"-" n in
    (* TODO: escape *)
    print_string v;
  print_string "</li>";
  print_string "\n"

let hello () =
  w "Content-type: text/html; charset=utf-8";
  w "";
  w "<html>
<head><title>Hello, Worλd</title></head>
<body>
<h1>OCaml, where art thou 🐫!</h1>
<ul>";
  va "HOME";
  va "HTTPS";
  va "HTTP_HOST";
  va "HTTP_COOKIE";
  va "HTTP_ACCEPT";
  va "REMOTE_ADDR";
  va "REMOTE_USER";
  va "REQUEST_METHOD";
  va "REQUEST_URI";
  va "PATH_INFO";
  va "QUERY_STRING";
  va "SERVER_NAME";
  va "SERVER_PORT";
  va "SERVER_SOFTWARE";
  w "</ul>
</body>
</html>";
  exit 0;;

