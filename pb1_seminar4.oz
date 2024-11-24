declare 
fun {Concat L1 L2} 
	case L1 of nil then L2
	[] H|T then H|{Concat T L2}
	end
end

declare
fun {Find E L} 
	case L of nil then false 
	[] H|T then 
		if H == E then true
		else {Find E T}
		end
	end
end

declare
fun {FreeSetHelper Expression L}
	case Expression of apply(Expr1 Expr2) then 
		{Concat {FreeSetHelper Expr1 L} {FreeSetHelper Expr2 L}}
	[] let(ID#Expr1 Expr2) then 
		{Concat {FreeSetHelper Expr1 ID|L} {FreeSetHelper Expr2 ID|L}}
	[] lam(ID Expr1) then 
		{FreeSetHelper Expr1 ID|L}
	[] ID then if {Find ID L} then nil else [ID] end
	end
end

declare 
fun {FreeSet Expression}
	{FreeSetHelper Expression nil}
end

{Browse {FreeSet apply(x let(x#y x))}}
{Browse {FreeSet apply(y apply(let(x#x x) y))}}
{Browse {FreeSet lam(x apply(y x))}}