open Graph
open Tools
open Printf


type label_arc = {  flot: int; capacity: int}
type graph_ff = label_arc graph
type path = id list

(*Display the label on the arcs, format : flow/capacity*)
let string_of_label label = sprintf "%d/%d \n" label.flot label.capacity 


(*Find the maximum value to increment the path*)
let rec max1 graph t1 path = match path with 
  | None -> None
  | Some [] -> Some max_int
  | Some (t2::q) ->  min (find_arc graph t1 t2) (max1 graph t2 (Some q))


(*Apply the incrementation to all the arcs on the path found*)
let rec incrementer graph aug t1 path = match path  with
  | None -> graph
  | Some [] -> graph
  | Some (t2::q) ->   let new_graph = add_arc graph t1 t2 (-aug) in 
    let new_graph = add_arc new_graph t2 t1 aug in
    incrementer new_graph aug t2 (Some q) ;;

(*Return the first node ID which has not already been visited*)
let rec trouver_voisin list_arcs node_list_aux = match list_arcs with
  | []          -> -1
  | (id,x) :: q -> if (List.mem id node_list_aux) || x == 0 then trouver_voisin q node_list_aux else id

(** The source change each recursive call, the sink does not change and node_list is the nodes list which are already visited*)

let rec find_path graph node_list source sink = 

  if source = sink then 
    Some []
  else

    match trouver_voisin (out_arcs graph source) node_list with
    | -1    -> None 
    | id    ->
      match find_path graph (id::node_list) id sink with
      | None      -> find_path graph (id::node_list) source sink (*if the actual node has not a neighbour not visited, we will take the parent node (node before)*)
      | Some path -> Some (id :: path)


let rec print_list = function
  | []    -> ()
  | [h]   -> printf "%d\n" h
  | h::t  -> printf "%d -> " h; print_list t

let print_path path = match path with
  | None      -> Printf.printf "No path found"
  | Some l    -> print_list l (*print the path without the source*)


(*return the flow*)
let get_real_flow graph id1 id2 = match find_arc graph id2 id1 with
  |None -> 0
  |Some x -> x

(*print answer*)
let display_solution graph source = 
  let out_arcs_src = out_arcs graph source in

  let rec out_arcs out_arcs_tmp = match out_arcs_tmp with
    | [] -> 0
    | [(_,{flot;_})] -> flot
    | (id,{flot;_}) :: t -> flot + (out_arcs t) 
  in
  let solution_src = out_arcs out_arcs_src in
  solution_src

(*******FORD FULKERSON ALGORITHM*********)
let rec ford_fulkerson base_graph changing_graph path source sink= match path with 
  | None -> let record_of_int a = {capacity = a ; flot = -50} in 
    let graph_tmpry = gmap base_graph record_of_int in
    let f_1 graphe id1 id2 label = 
      let change_label label = {flot = (get_real_flow (gmap changing_graph int_of_string) id1 id2); capacity = label.capacity } in
      new_arc graphe id1 id2 (change_label label) in
    let graph_fulkerson = e_fold graph_tmpry f_1 graph_tmpry in
    let solution = display_solution graph_fulkerson source in
    Printf.printf "------ Solution = %d ------\n" solution;
    graph_fulkerson
  | Some _ -> 
    let () = print_path path in
    let graph_int = gmap changing_graph int_of_string in
    let max_flow = max1 graph_int source path in
    let string_of_opt opt = match opt with
      |None -> -99
      |Some x -> x
    in
    let new_value = string_of_opt (max_flow) in
    Printf.printf "value = %d\n" new_value;
    let new_graph = incrementer graph_int new_value source path in
    let new_path = (find_path new_graph [] source sink) in
    ford_fulkerson base_graph (gmap new_graph string_of_int) new_path source sink



