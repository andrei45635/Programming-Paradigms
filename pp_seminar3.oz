%%%%% SEMINAR 3 - PROGRAMMING PARADIGMS %%%%%

%%% ex. 1 %%% 
declare
fun {FindElement List Element}
    case List of 
    nil then false
    [] H|T then
        if Element == H then true
        else {FindElement T Element}
        end
    end
end

% Tests
{Browse {FindElement [a b c] b} == true}
{Browse {FindElement [a b c] d} == false}
{Browse {FindElement nil b} == false}

%%% ex. 2 %%% 
declare
fun {Take List Nr}
    case List of
    nil then nil
    [] H|T then
        if Nr > 0 then H|{Take T Nr-1}
        else nil
        end
    end
end

fun {Drop List Nr}
    case List of
    nil then nil
    [] H|T then
        if Nr > 0 then {Drop T Nr-1}
        else H|{Drop T Nr}
        end
    end
end

fun {Drop2 List Nr}
    if Nr == 0 then List
    else 
        case List of
            nil then nil
            [] H|T then {Drop T Nr-1}
        end
    end
end

% Tests

{Browse {Take [a b c d] 2} == [a b]}

{Browse {Drop [a b c d] 2} == [c d]}
{Browse {Drop2 [a b c d] 2} == [c d]}

%%% ex. 3 %%%
declare
fun {Zip List1#List2}
    case List1 of
    nil then nil
    [] H|T then
        case List2 of
        nil then nil
        [] H1|T1 then H#H1|{Zip T#T1}
        end
    end
end

declare
fun {Unzip_aux L L1 L2}
   case L of nil then L1#L2
   [] H|T then
      case H of 
      A#B then {Unzip_aux T {List.append L1 [A]} {List.append L2 [B]}}
      end
   end
end

fun {Unzip L}
   {Unzip_aux L nil nil}
end

% Tests
{Browse {Zip nil#[1 2]} == nil}
{Browse {Zip [1 2]#nil} == nil}
{Browse {Zip [a b c]#[a b c]} == [a#a b#b c#c]}

{Browse {Unzip [a#1 b#2 c#3]} == [a b c]#[1 2 3]}
{Browse {Unzip nil} == nil#nil}

%%% ex. 4 %%%
declare
fun {Position_aux List Element Acc}
    case List of
    nil then 0
    [] H|T then 
        if H == Element then Acc
        else {Position_aux T Element (Acc+1)}
	    end
   end
end

fun {Position List Element}
    {Position_aux List Element 1}
end

% Tests
{Browse {Position [1 2 3] 2} == 2}
{Browse {Position [1 2 3] 5} == 0}

%%% ex. 5 %%%
declare
fun {Evaluate Expression}
    case Expression of
    int(N) then N
    [] add(X Y) then {Evaluate X} + {Evaluate Y}
    [] mul(X Y) then {Evaluate X} * {Evaluate Y}
    end
end

% Tests
{Browse {Evaluate add(int(1) mul(int(3) int(4)))} == 13}