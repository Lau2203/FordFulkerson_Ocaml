open Gfile
open Tools
open Fordfulkerson 

(*let test graph source sink = 


   Function applied to Gmap
  let int_graph_of_string_graph a = int_of_string a in
  let string_graph_of_int_graph a = string_of_int a in

  (* Test add_arc*)

  let int_graph = gmap graph int_graph_of_string_graph  in (*Creating an int_graph*)

  let graph_add_arc= add_arc int_graph 3 1 5 in (*adding n to the specified arc*)

  let string_graph = gmap graph_add_arc string_graph_of_int_graph in (*Switching the int_graph to a string_graph in order to print it *)





    let _ = Fordfulkerson.do_it graph source sink in

    ()

*)
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
  (* let _ = test graph _source _sink in *)


  let path = (find_path int_graph [] source sink) in
  let () = print_path path in
  let _max_flow = max1 int_graph source path in

  (* let string_of_opt opt = match opt with
     |None -> -99
     |Some x -> x
     in
     let valu = string_of_opt (max_flow) in
     Printf.printf "value = %d\n" valu;
     let graph_incrementer = incrementer int_graph valu source path in 
     let graph_incr = gmap graph_incrementer string_of_int in*)

  let graph_fulkerson = ford_fulkerson int_graph graph path source sink in
  let ford_fulkerson_solution = gmap graph_fulkerson string_of_label in



  (* END TEST*)
  (* Rewrite the graph that has been read. *)
  (* Test export*)
  let () = write_file outfile ford_fulkerson_solution in
  let() = export_file (outfile ^ ".dot") ford_fulkerson_solution in
  ()
