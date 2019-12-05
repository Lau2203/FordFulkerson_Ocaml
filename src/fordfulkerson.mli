open Graph



type label_arc = { flot: int; capacity: int };;
type graph_ff = label_arc graph ;; 
type path = id list ;; 

val get_real_flow : int graph -> id -> id -> int

val string_of_label : label_arc -> string  

val find_path : int graph -> id list -> id -> id -> path option

val print_path: path option -> unit

val max1: int graph -> id -> id list option -> int option

val incrementer: int graph -> int -> id -> id list option -> int graph

val ford_fulkerson : int graph -> string graph -> id list option -> id -> id ->  label_arc graph

val display_solution : label_arc graph -> id -> int