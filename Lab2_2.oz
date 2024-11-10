declare

fun { ReverseAcc L Acc }
   case L
   of nil then Acc
   [] H|T then {ReverseAcc T H|Acc}
   end
end

fun {Reverse L}
   {ReverseAcc L nil}
end

{Browse {Reverse ['I' 'want' 2 go 'there']}}