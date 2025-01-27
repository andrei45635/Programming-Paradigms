%%%%% SEMINAR 2 - PROGRAMMING PARADIGMS %%%%%

/* Write a function that computes the number of possible combinations */

declare
fun {Numerator N CopyN K}
   if N < CopyN - K + 1 then 1
   else N * {Numerator N - 1 CopyN K}
   end
end


declare
fun {Denominator K}
   if K == 1 then 1
   else K * {Denominator K-1}
   end
end

declare
fun {Comb N K}
   if K == 0 then 1
   else
      {Numerator N N K} div {Denominator K}
   end
end

% Tests
{Browse {Comb 3 0} == 1}
{Browse {Comb 6 1} == 6}
{Browse {Comb 12 4} == 495}



/* Comb2(n, k) = {
    1, k == 0
    n, k == 1
    Comb2(n, k-1) * (n-k+1)/k, otherwise 
}*/

declare
fun {Comb2 N K}
    if K == 0 then 1
    else if K == 1 then N
        else 
            {Comb2 N K-1} * (N-K+1) div K
        end
    end
end

% Tests
{Browse {Comb2 3 0} == 1}
{Browse {Comb2 6 1} == 6}
{Browse {Comb2 12 4} == 495}


/* Write a definition of a function that revers a list without using append calls */

/* Reverse_helper(l, aux) = {
    aux, l == nil
    h,t = l; Reverse_helper(T, h+aux), default    
} */

declare
fun {Reverse_aux L AUX}
    case L of 
    nil then AUX
    [] H|T then {Reverse_aux T H|AUX}
    end
end

/* Reverse(l) = { Reverse_helper(l, nil) } */

declare
fun {Reverse L}
    {Reverse_aux L nil}
end

% Tests
{Browse {Reverse [1 2 3 4 5]}}

/* Modify the functions bellow for lazy evaluations.
 Write a function {GetAfter N} that will return the first 
 prime number after a given value */

declare
fun lazy {Sieve L}
   case L of
      nil then nil
   [] H|T then H|{Sieve {Filter T H}}
   end
end

fun lazy {Filter L H}
   case L of
      nil then nil
   [] A|As then
      if (A mod H)==0 then {Filter As H}
      else A|{Filter As H} end
   end
end

fun lazy {Prime} {Sieve {Gen 2}} end

fun lazy {Gen N} N|{Gen N+1} end

fun {ExtractNext N L}
   case L of
      nil then nil
   [] H|T then if (H > N) then H
	       else {ExtractNext  N T}
	       end
   end
end

fun {GetAfter N}
   {ExtractNext N {Prime}}
end

% Tests  
{Browse {GetAfter 10} == 11}
{Browse {GetAfter 3} == 5}
{Browse {GetAfter 13} == 17}

/* Consider a BST of the following form:
    <BTree> ::= leaf(<Int>) | node(<Int>, <BTree>, <BTree>)
*/

% Insertions of new value in BST
declare

proc {Preorder X}
   if X \= nil then {Browse X.value}
      if X.left \= nil then {Preorder X.left} end
      if X.right \= nil then {Preorder X.right} end
   end
end

fun {Insert R N}
   if R == nil then node(value:N left:nil right:nil)
   else if N < R.value then node(value:R.value left:{Insert R.left N} right:R.right)
	else
	   node(value:R.value left:R.left right:{Insert R.right N})
	end
   end
end

% Return smallest value in BST
fun {Smallest R}
   if R == nil then false
   else if R.left == nil then R.value
	else {Smallest R.left}
	end
   end
end

% Return largest value BST
fun {Biggest R}
   if R == nil then false
   else if R.right == nil then R.value
	else {Biggest R.right}
	end
   end
end

% Checks if the given tree is sorted
fun {IsSortedBST R}
   if R == nil then true
   else if {Smallest R} > R.value then false
	else if {Biggest R} < R.value then false
	     else if {And {IsSortedBST R.left} {IsSortedBST R.right}} then true
		  else false
		  end
	     end
	end
   end
end

declare

R = node(value:5 left:X1 right:X2)
X1 = node(value:3 left:nil right:nil)
X2 = node(value:6 left:nil right:nil)

T = node(value:2 left:T1 right:T2)
T1 = node(value:3 left:nil right:nil)
T2 = node(value:6 left:nil right:nil)

% Tests

{Browse 'Visualize tree'}
{Preorder R}

A = {Insert R 4}

{Browse 'Visualize tree after insertion'}
{Preorder A}

{Browse {Smallest A} == 3}
{Browse {Biggest A} == 6}
{Browse {IsSortedBST A} == true}
{Browse {IsSortedBST T} == false}