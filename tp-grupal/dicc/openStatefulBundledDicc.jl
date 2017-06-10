
type JuliaTree
    key::String
    values::Array{Int}
    left
    right
    
    JuliaTree() = new("",[],nothing,nothing)
end
type JuliaDict
    tree::JuliaTree
    JuliaDict() = new(JuliaTree())
end


function insert!(key::String, value::Int, tree::JuliaTree)
    if (length(tree.key) == 0)
        tree.key=key
        push!(tree.values,value)
    elseif (key==tree.key)
        push!(tree.values,value)
    elseif (key<tree.key)
        tree.left = insert!(key,value,tree.left)
    elseif (key>tree.key)
        tree.right = insert!(key,value,tree.right)  
    end
end
function insert!(key::String, value::Int, tree::Any)
    new_tree = JuliaTree()
    if (!isa(tree,JuliaTree))
        new_tree = JuliaTree()
        new_tree.key = key
        push!(new_tree.values,value)
    end
    new_tree
end

function lookup(key::String, tree::JuliaTree)
    value = []
    if (key==tree.key)
        value = tree.values
    elseif (key<tree.key)
        value = lookup(key,tree.left)
    else
        value = lookup(key,tree.right)
    end
    return value
end

function lookup(key::String, tree::Any)
    if (!isa(tree,JuliaTree))
        return []
    else throw(MethodError)
    end
end


import Base.get
function put!(key::String, value::Int, dict::JuliaDict)
    insert!(key,value,dict.tree)
end
function get(key::String, dict::JuliaDict)
    lookup(key,dict.tree)
end

function get_keys(tree::JuliaTree)
    keys = []
    if (isa(tree.left,JuliaTree))
        left_keys = get_keys(tree.left)
        append!(keys,left_keys)
    end
    if (isa(tree.right,JuliaTree))
        right_keys = get_keys(tree.right)
        append!(keys,right_keys)
    end
    if (length(tree.key) > 0)
        push!(keys,(tree.key,length(tree.values)))
    end
    keys
end
function domain(dict::JuliaDict)
    keys = get_keys(dict.tree)
    sort(keys,by=x->x[2],rev=true)
end

dict = JuliaDict()
put!("a",55,dict)
put!("b",1,dict)
put!("a",11,dict)
get("a",dict)
get("b",dict)
domain(dict)


