%%%%% SEMINAR 4 - PROGRAMMING PARADIGMS %%%%%

%%% ex. 1 %%%
declare
fun {Concat List1 List2}
   case List1 of
      nil then List2
   [] H|T then H|{Concat T List2}
   end
end

fun {Find List X}
    case List of 
      nil then false
      [] H|T then 
            if H == X then true 
            else {Find T X} 
            end
      end
end

declare
fun {FreeSet_aux Expression List}
   case Expression of
      apply(Expression1 Expression2) then 
            {Concat {FreeSet_aux Expression1 List} {FreeSet_aux Expression2 List}}
      
      [] lam(ID Expression1) then 
            {FreeSet_aux Expression1 ID|List}
      
      [] let(ID#Expression1 Expression2) then 
            {Concat {FreeSet_aux Expression1 ID|List} {FreeSet_aux Expression2 ID|List}}
      
      [] ID then
            if {Find List ID} then nil 
            else [ID] 
            end
    end
end

fun {FreeSet Expression}
    {FreeSet_aux Expression nil}
end


% Tests

{Browse {FreeSet apply(x let(x#y x))} == [x y]}
{Browse {FreeSet apply(y apply(let(x#x x) y))} == [y y]}
{Browse {FreeSet lam(x apply(y x))} == [y]}

%%% ex. 2 %%%
declare
fun {IsMember Environment ID}
   case Environment of
      nil then false
      [] A#B|T then 
            if ID == A then true 
            else {IsMember T ID} 
            end
      end
end


declare
fun {Fetch Environment ID}
   case Environment of
      nil then ID
   []  A#B|T then 
        if ID == A then B 
        else {Fetch T ID} 
        end
   end
end


declare
fun {Adjoin_aux Environment Expression}
   case Environment of
      nil then nil
   [] A#B|T then
      case Expression of
        X#Y then 
            if A == X then {Adjoin_aux T Expression}
            else (A#B)|{Adjoin_aux T Expression} 
            end
        end	 
   end
end

fun {Adjoin Environment Expression}
   Expression | {Adjoin_aux Environment Expression}
end


% Tests

{Browse {IsMember [a#e1 b#y c#e3] c} == true}
{Browse {IsMember [a#e1 b#y c#e3] y} == false}

{Browse {Fetch [a#e1 b#y c#e3] c} == e3}
{Browse {Fetch [a#e1 b#y c#e3] d} == d}

{Browse {Adjoin [a#e1 b#y c#e3] c#e4} == [c#e4 a#e1 b#y]}
{Browse {Adjoin [a#e1 b#y c#e3] d#e4} == [d#e4 a#e1 b#y c#e3]}

%%% ex. 3 %%%
declare
Cnt={NewCell 0}
fun {NewId}
   Cnt:=@Cnt+1
   {String.toAtom {Append "id<" {Append {Int.toString @Cnt} ">"}}}
end

declare
fun {Rename_aux Expression Environment}
   if {IsAtom Expression} then 
      if {IsMember Environment Expression} then {Fetch Environment Expression} 
      else Expression 
      end
   else
   case Expression of
   nil then nil
   
   [] apply(Expression1 Expression2) then 
         apply({Rename_aux Expression1 Environment} {Rename_aux Expression2 Environment})
   
   [] lam(ID Ex) then
         if {IsMember Environment ID} then lam({Fetch Environment ID} {Rename_aux Ex Environment})
         else
            local Envs in
               Envs = {Adjoin Environment ID#{NewId}}
               lam({Fetch Envs ID} {Rename_aux Ex Envs})
            end
         end  
   
   [] let(ID#Expression1 Expression2) then
         if {IsMember Environment ID} then
            let({Fetch Environment ID}#{Rename_aux Expression1 Environment} {Rename_aux Expression2 Environment})
         else
            local Envs in
               Envs = {Adjoin Environment ID#{NewId}}
               let({Fetch Envs ID}#{Rename_aux Expression1 Envs} {Rename_aux Expression2 Envs})
            end
         end  
   end
   end
end

fun {Rename E}
   {Rename_aux E nil}
end


% Tests

{Browse {Rename lam(z lam(x z))} == lam('id<1>' lam('id<2>' 'id<1>'))}
{Browse {Rename let(id#lam(z z) apply(id y))} == let('id<3>'#lam('id<4>' 'id<4>') apply('id<3>' y))}

%%% ex. 4 %%%
declare
fun {ReplaceIn Expression ID NewId}
   case Expression of 
   nil then Expression
   
   [] let(Left#Right Result) then
        let({ReplaceIn Left ID NewId}#{ReplaceIn Right ID NewId} {ReplaceIn Result ID NewId})
   
   [] lam(T Body) then
        lam({ReplaceIn T ID NewId} {ReplaceIn Body ID NewId})
   
   [] apply(Left Right) then
        apply({ReplaceIn Left ID NewId} {ReplaceIn Right ID NewId})
   
   [] T then 
        if T == ID then NewId 
        else T 
        end
   end
end

fun {Subs Binding InExpression}
    case Binding of 
    nil then nil
    [] Id#Expression then
        {ReplaceIn {Rename InExpression} Id Expression}
    end
end


% Tests

{Browse {Subs x#lam(x x) apply(x y)} == apply(lam(x x) y)}
{Browse {Subs x#lam(z z) apply(x lam(x apply(x z)))} == apply(lam(z z) lam('id<5>' apply('id<5>' z)))}