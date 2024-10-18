declare 
fun lazy {Sieve L} case L of
		      nil then nil
		   [] H|T then H|{Sieve {Filter T H}}
		   end end

fun lazy {Filter L H}
   case L of
      nil then nil
   [] A|As then if (A mod H) == 0 then {Filter As H}
		else A|{Filter As H} end
   end end

fun lazy {Prime} {Sieve {Gen 2}} end

fun lazy {Gen N} N|{Gen N+1} end

declare
Primes = {Sieve {Gen 2}}

declare
fun {GetPrime N L}
   case L of
      nil then nil
   [] H|T then if (H > N) then H
	       else {GetPrime N T}
	       end
   end
end

declare
fun {GetAfter N}
   {GetPrime N Primes}
end

{Browse {GetAfter 10}}
{Browse {GetAfter 3}}
{Browse {GetAfter 13}}
{Browse {GetAfter 17}}
{Browse {GetAfter 100}}