(* 
 * https://caml.inria.fr/pub/docs/u3-ocaml/ocaml-steps.html 
 *
 * extract some stuff about the request:
 * - request uri
 * - cookie(s)
 * - POST form data
 *
 * Response:
 * - http status + reason
 * - header
 *   - content-type
 *   - server
 * - body
 *   - xml+atom (syndic) with xslt and comment prefix,
 *   - xhtml or
 *   - text/plain
 *
 * http://cumulus.github.io/Syndic/syndic/Syndic__/Syndic_atom/#input-and-output
 *
 * other cgi lib:
 * https://gitlab.com/gerdstolpmann/lib-ocamlnet3/blob/master/code/examples/cgi/netcgi2/add.ml
 * http://projects.camlcity.org/projects/dl/ocamlnet-4.1.6/doc/html-main/Netcgi.html#TYPEexn_handler
 *)

(* https://github.com/rixed/ocaml-cgi/blob/master/cgi.ml#L169 *)
let safe_getenv ?default s =
  try
    Sys.getenv s
  with Not_found ->
    match default with
    | Some d -> d
    | None ->
      failwith ("Cgi: the environment variable " ^ s ^ " is not set")

let w s = 
  print_string s;
  print_string "\n";;

let va n =
  print_string "<li>";
  print_string n;
  print_string ": ";
  let v = safe_getenv ~default:"-" n in
    (* TODO: escape *)
    print_string v;
  print_string "</li>";
  print_string "\n";;

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

