declare
fun {Member Xs Y}
	case Xs of nil then false
	[] H|T then 
		if (Y == H) then true
		else {Member T Y}
		end
	end
end

{Browse {Member [a b c] b}}
{Browse {Member [a b c] d}}
{Browse {Member nil d}}
