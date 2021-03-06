open Gfile
open Tools
open Fordfulkerson 

let () =

  (* Check the number of command-line arguments *)
  if Array.length Sys.argv <> 5 then
    begin
      Printf.printf "\nUsage: %s infile source sink outfile\n\n%!" Sys.argv.(0) ;
      exit 0
    end ;

  (* Arguments are : infile(1) source-id(2) sink-id(3) outfile(4) *)
  let infile = Sys.argv.(1)
  and outfile = Sys.argv.(4)

  (* These command-line arguments are not used for the moment. *)
  and source = int_of_string Sys.argv.(2)
  and sink = int_of_string Sys.argv.(3)
  in
  (* Open file *)
  let graph = from_file infile in

  (* START TEST*)
  (* Test clone_nodes_graph*)
  let int_graph = gmap graph int_of_string  in 

  let path = (find_path int_graph [] source sink) in
  let () = print_path path in
  let _max_flow = max1 int_graph source path in

  let graph_fulkerson = ford_fulkerson int_graph graph path source sink in
  let ford_fulkerson_solution = gmap graph_fulkerson string_of_label in

  (* END TEST*)
  (* Rewrite the graph that has been read. *)
  (* Test export*)
  let () = write_file outfile ford_fulkerson_solution in
  let() = export_file (outfile ^ ".dot") ford_fulkerson_solution in
  ()
