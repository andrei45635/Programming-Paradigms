declare
fun {Zip Xs#Ys}
	case Xs of nil then nil
	[] H|T then
		case Ys of nil then nil
			[] H1|T1 then H#H1|{Zip T#T1}
		end
	end
end

{Browse {Zip nil#[1 2]}}
{Browse {Zip [1 2]#nil}}
{Browse {Zip [a b c]#[a b c]}}


fun {UnZipHelper L Xs Ys}
	case L of nil then Xs#Ys
	[] H|T then 
		case H of
			A#B then {UnZipHelper T {List.append Xs [A]} {List.append Ys [B]}}
		end
	end
end

fun {UnZip Xs}
	{UnZipHelper Xs nil nil}
end

{Browse {UnZip [a#1 b#2 c#3]}}
{Browse {UnZip nil}}