(* A is an n * n square matrix stored in column major order *)
(* Therefore the determinant is calculated recursively
	 using cofactor expansion always on the first row *)

(* Commands for increasing the print length and depth in the repl *)
Control.Print.printLength := 100000000;
Control.Print.printDepth := 100000000;

structure D = Date
(* Global mutable references for counting determinants of various sizes *)
val count15 = ref 0
val count14 = ref 0
val count13 = ref 0
val count12 = ref 0
val count11 = ref 0

(* Rests the global variables to have accurate logging over multiple tests *)
fun reset () =
  (count15 := 0; count14 := 0; count13 := 0; count12 := 0; count11 := 0)

(* Logging function *)
fun printCounts () =
  let
    val _ = print ("\n")
    val _ = print (D.fmt "%a %b %d %Y: %Hh %Mmin %Ssec" (D.fromTimeLocal  (Time.now ())) ^ " | ")
    val _ = print ("15x15: " ^ Int.toString (!count15 - 1) ^ " ")
    val _ = print ("14x14: " ^ Int.toString (!count14 - 1) ^ " ")
    val _ = print ("13x13: " ^ Int.toString (!count13 - 1) ^ " ")
    val _ = print ("12x12: " ^ Int.toString (!count12 - 1) ^ " ")
    val _ = print ("11x11: " ^ Int.toString (!count11 - 1) ^ "\n")
  in
    ()
  end

(* Helper functions *)
fun rmCol (c, l) =
  List.filter (fn x => not (x = c)) l

fun rmColRow (c, l) =
  List.map (fn x => List.tl x) (rmCol (c, l))

fun mkminors l =
  List.map (fn x => rmColRow (x, l)) l

fun det ([], [], _, acc) = acc
  | det (x :: l1, y :: l2, b, acc) =
      if b then det (l1, l2, false, acc + x * y)
      else det (l1, l2, true, acc - x * y)

fun getRow1 l =
  List.map (fn x => List.hd x) l

(* Main function *)
fun determinant [[a]] = a
  | determinant [[a, c], [b, d]] = a * d - b * c
  | determinant (l) =
      let
        val _ =
          case length l of
            15 => count15 := !count15 + 1
          | 14 => count14 := !count14 + 1
          | 13 => count13 := !count13 + 1
          | 12 => count12 := !count12 + 1
          | 11 => count11 := !count11 + 1
          | _ => ()
        (* Only logs for matrices bigger than 10x10 *)
        val _ = if length l > 10 then printCounts () else ()
      in
        det
          (getRow1 l, (List.map (fn x => determinant x) (mkminors l)), true, 0)
      end

(* Tests *)
(* Comment and uncomment each of these to run tests to your liking *)

val A2 = [[1, 3], [2, 4]]
val detA2 = determinant A2
val ~2 = detA2
val _ = reset ()


val A3 = [[9, 4, 3], [2, 5, 8], [7, 6, 1]]
val detA3 = determinant A3
val ~240 = detA3
val _ = reset ()

val A5 =
  [ [1, 2, 3, 4, 5]
  , [5, 4, 3, 2, 1]
  , [2, 3, 4, 5, 1]
  , [4, 5, 1, 2, 3]
  , [3, 1, 5, 4, 2]
  ]
val detA5 = determinant A5
val ~150 = detA5
val _ = reset ()

val A10 =
  [ [5, 5, 3, 3, 9, 3, 7, 7, 7, 3]
  , [9, 2, 6, 2, 8, 1, 2, 1, 8, 5]
  , [10, 10, 10, 8, 2, 6, 3, 7, 1, 5]
  , [9, 4, 9, 3, 1, 5, 1, 3, 6, 6]
  , [4, 3, 1, 8, 9, 5, 1, 6, 3, 4]
  , [10, 2, 7, 3, 6, 3, 1, 3, 1, 7]
  , [4, 3, 4, 6, 10, 5, 5, 3, 3, 4]
  , [5, 8, 1, 8, 7, 3, 10, 6, 7, 4]
  , [9, 10, 7, 9, 1, 4, 3, 10, 9, 2]
  , [10, 9, 1, 7, 6, 5, 4, 4, 1, 8]
  ]
val detA10 = determinant A10
val 48329415 = detA10
val _ = reset ()

(* val A12 = [
[2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 1, 2],
[1, 1, 2, 2, 1, 1, 2, 2, 1, 2, 1, 1],
[2, 2, 2, 2, 1, 2, 2, 2, 1, 2, 2, 2],
[1, 1, 2, 2, 2, 2, 1, 2, 1, 2, 1, 1],
[1, 2, 1, 2, 2, 1, 2, 1, 2, 1, 2, 2],
[1, 1, 1, 1, 1, 1, 1, 2, 2, 1, 2, 1],
[1, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 1],
[1, 1, 2, 1, 2, 2, 2, 2, 1, 1, 1, 2],
[1, 2, 1, 2, 2, 2, 2, 1, 2, 1, 1, 1],
[2, 2, 2, 2, 2, 2, 2, 1, 2, 1, 1, 2],
[1, 1, 2, 1, 2, 1, 2, 2, 2, 1, 1, 1],
[2, 2, 2, 2, 1, 1, 2, 1, 1, 2, 1, 2]
]
val detA12 = determinant A12
val 2 = detA12
val _ = reset () *)

(* val A12b =
  [ [9, 9, 5, 7, 2, 3, 3, 5, 8, 3, 3, 8]
  , [7, 7, 5, 8, 3, 9, 6, 9, 2, 8, 2, 4]
  , [8, 7, 5, 6, 8, 5, 8, 7, 6, 3, 3, 4]
  , [3, 5, 8, 9, 4, 3, 2, 8, 6, 9, 3, 5]
  , [8, 5, 6, 8, 2, 4, 8, 4, 2, 5, 4, 4]
  , [2, 7, 6, 5, 2, 7, 3, 6, 6, 3, 5, 3]
  , [8, 6, 6, 2, 9, 2, 4, 8, 3, 4, 7, 2]
  , [4, 6, 6, 4, 2, 5, 3, 4, 3, 3, 2, 6]
  , [5, 5, 2, 2, 6, 5, 2, 2, 6, 5, 2, 5]
  , [4, 3, 2, 5, 2, 8, 2, 7, 3, 2, 2, 5]
  , [3, 2, 8, 2, 8, 4, 6, 2, 4, 9, 3, 8]
  , [8, 3, 2, 7, 5, 3, 8, 5, 2, 8, 7, 4]
  ]
val detA12b = determinant A12b
val 2801572725 = detA12b
val _ = reset () *)

(* val A15 =
  [ [2, 2, 2, 1, 2, 2, 1, 1, 2, 2, 1, 2, 1, 1, 1]
  , [2, 2, 1, 2, 2, 1, 1, 1, 2, 2, 2, 1, 2, 2, 1]
  , [2, 1, 1, 1, 1, 2, 2, 1, 1, 1, 2, 2, 2, 1, 2]
  , [1, 2, 1, 1, 1, 1, 2, 1, 2, 2, 1, 1, 1, 1, 2]
  , [2, 1, 2, 2, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2]
  , [2, 2, 2, 1, 2, 1, 2, 1, 1, 2, 2, 2, 1, 2, 1]
  , [1, 2, 2, 1, 2, 2, 1, 1, 1, 1, 2, 1, 2, 1, 2]
  , [1, 1, 2, 1, 1, 2, 2, 2, 1, 2, 1, 2, 2, 1, 1]
  , [1, 1, 2, 1, 2, 1, 2, 1, 2, 1, 1, 2, 2, 2, 1]
  , [2, 2, 2, 2, 2, 1, 1, 2, 2, 1, 1, 1, 2, 2, 2]
  , [1, 2, 2, 1, 2, 2, 1, 1, 2, 1, 1, 2, 2, 1, 1]
  , [2, 2, 1, 2, 2, 2, 2, 2, 1, 1, 2, 2, 1, 2, 2]
  , [1, 2, 1, 2, 1, 2, 2, 2, 1, 2, 2, 2, 2, 1, 1]
  , [2, 2, 2, 1, 1, 2, 2, 1, 1, 1, 1, 2, 1, 2, 1]
  , [2, 2, 2, 1, 2, 1, 1, 2, 2, 1, 2, 1, 1, 1, 1]
  ]
val detA15 = determinant A15
val 4 = detA15
val _ = reset () *)

(* EOF *)
val _ = ();

(* Automatic exit to use Linux time option to get results *)
OS.Process.exit
OS.Process.success
