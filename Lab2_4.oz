declare
   fun {Insert Tree Value}
      case Tree
      of nil then leaf(Value)
      [] leaf(V) then
         if Value < V then node(V leaf(Value) nil)
         else node(V nil leaf(Value))
         end
      [] node(V Left Right) then
         if Value < V then node(V {Insert Left Value} Right)
         else node(V Left {Insert Right Value})
         end
      end
   end

   fun {Smallest Tree}
      case Tree
      of nil then nil
      [] leaf(V) then V
      [] node(V Left _) then
	 if Left == nil then V
	 else {Smallest Left}
	 end
      end
   end

   fun {Biggest Tree}
      case Tree
      of nil then nil
      [] leaf(V) then V
      [] node(V _ Right) then
	 if Right == nil then V
	 else {Biggest Right}
	 end
      end
   end

fun {IsSortedBST Tree}
   case Tree
   of nil then true
   [] leaf(V) then true
   [] node(V Left Right) then
      (Left == nil orelse {Biggest Left} < V) andthen
      (Right == nil orelse V =< {Smallest Right}) andthen
      {IsSortedBST Left} andthen {IsSortedBST Right}
   end
end

local
   T1 = node(3 nil (node(5 (leaf(4)) nil)))
in
   {Browse {Insert T1 1}}
   {Browse {Biggest T1}}
   {Browse {Smallest T1}}
   {Browse {IsSortedBST T1}}
end

