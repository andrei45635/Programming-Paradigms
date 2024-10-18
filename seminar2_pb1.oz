declare
fun {Fact N}
   if N == 1 orelse N == 0 then
      1
   elseif N < 0 then
      0
   else
      N * {Fact (N - 1)}
   end
end

{Browse {Fact 3}}
{Browse {Fact 0}}
{Browse {Fact 10}}
   
declare
fun {Comb N K}
   {Fact N} div ({Fact K} * {Fact N-K})
end

{Browse {Comb 5 2}}

declare
fun {Comb2 N K}
   fun {CombHelper N K Num Denom}
      if K == 0 then
	 Num div Denom
      else
	 {CombHelper (N - 1) (K - 1) (N * Num) (K * Denom)}
      end
   end
in
   {CombHelper N K 1 1}
end

{Browse {Comb2 5 2}}

declare
fun {Numerator N K}
   if K == 0 then
      1
   else
      N * {Numerator (N - 1) (K - 1)}
   end   
end

declare
fun {Denominator K}
   if K == 1 then 1
   else
      K * {Denominator (K - 1)}
   end
end

declare
fun {Comb3 N K}
   if K == 0 then 1
   else
      {Numerator N K} div {Denominator K}
   end
end

{Browse {Comb3 3 0}}
{Browse {Comb3 6 1}}
{Browse {Comb3 12 4}}

declare
fun {Comb4 N K}
   if K == 0 then 1
   else if K == 1 then N
	else
	   (N - K + 1) * {Comb4 N (K - 1)} div K
	end
   end
end

{Browse {Comb4 3 0}}
{Browse {Comb4 6 1}}
{Browse {Comb4 12 4}}
{Browse {Comb4 25 10}}
