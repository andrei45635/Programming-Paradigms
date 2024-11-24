declare
Cnt = {NewCell 0}
fun {NewId}
    Cnt := @Cnt + 1
    {String.toAtom {Append "id<" {Append {Int.toString @Cnt} ">"}}}
end

fun {IsMember Env Key}
    case Env of
        nil then false
    [] (K#V)|Rest then
        if K == Key then true
        else {IsMember Rest Key}
        end
    end
end

fun {Fetch Env Key}
    case Env of
        nil then
            raise error('Key not found: ' # Key) end
    [] (K#V)|Rest then
        if K == Key then V
        else {Fetch Rest Key}
        end
    end
end

fun {Adjoin Env Pair}
    Pair | Env
end

declare
fun {RenameHelper Expr Env}
    if {IsAtom Expr} then
        if {IsMember Env Expr} then
            {Fetch Env Expr}
        else
            Expr
        end
    else
        case Expr of
            nil then nil
        [] apply(Expr1 Expr2) then
            apply({RenameHelper Expr1 Env} {RenameHelper Expr2 Env})
        [] lam(ID Expr) then
            if {IsMember Env ID} then
                lam({Fetch Env ID} {RenameHelper Expr Env})
            else
                local Envs in
                    Envs = {Adjoin Env ID#{NewId}}
                    lam({Fetch Envs ID} {RenameHelper Expr Envs})
                end
            end
        [] let(ID#Expr1 Expr2) then
            if {IsMember Env ID} then
                let({Fetch Env ID}#{RenameHelper Expr1 Expr2} {RenameHelper Expr2 Env})
            else
                local Envs in
                    Envs = {Adjoin Env ID#{NewId}}
                    let({Fetch Envs ID}#{RenameHelper Expr1 Env} {RenameHelper Expr2 Envs})
                end
            end
        end  
    end      
end

declare
fun {Rename Expression}
    {RenameHelper Expression nil}
end

{Browse {Rename lam(z lam(x z))}}
{Browse {Rename let(id#lam(z z) apply(id y))}}
