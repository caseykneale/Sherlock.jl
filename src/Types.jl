@enum ENTITY_TYPES
    is_function         = 1
    is_type             = 2
    is_abstract_type    = 3
    is_undefined        = 4
    is_mystery          = 5
end

struct Detective
    moduleinst        ::Module
    modulename        ::Symbol
    allnames          ::Vector{Symbol}
    functions         ::Vector{Symbol}
    types             ::Vector{Symbol}
    abstracttypes     ::Vector{Symbol}
    undefined_exports ::Vector{Symbol}
    graph             ::SimpleDiGraph
    nv                ::Int
    tag               ::Dict{Int, Symbol}
    lookup            ::Dict{Symbol, Int}
end

#Some convenience functions
functions(d::Detective)::Vector{Symbol} = d.functions
types(d::Detective)::Vector{Symbol} = d.types
abstracttypes(d::Detective)::Vector{Symbol} = d.abstracttypes
undefined(d::Detective)::Vector{Symbol} = d.undefined_exports

function inquire( d::Detective, s::Union{Symbol,String} )
    if isa(s, String)
        s = Symbol(s)
    end
    typeis = nothing
    if s in d.functions
        typeis = is_function
    elseif s in d.types
        typeis = is_type
    elseif s in d.abstracttypes
        typeis = is_abstract_type
    elseif s in d.undefined_exports
        typeis = is_undefined
    else
        typeis = is_mystery
    end
    return typeis
end

function safeisfield(m::Module, s::Symbol, t::Type)
    try
        f = getfield(m, s)
        return isa(f, t) && !isa(f, Function)
    catch
        return false
    end
end

function safeisnotabstract(m::Module, s::Symbol, t::Type)
    result = safeisfield(m, s, t)
    if (result && hasfield( typeof(getfield(m, s)), :abstract))
        return !getfield(m, s).abstract
    else
        return false
    end
end

function safeisabstract(m::Module, s::Symbol, t::Type)
    result = safeisfield(m, s, t)
    if (result && hasfield( typeof(getfield(m, s)), :abstract))
        return getfield(m, s).abstract
    else
        return false
    end
end

"""
    Detective( moduleinst::Module )

Instantiate Detective object via a module.

"""
function Detective(moduleinst::Module)
    modname     = Symbol(moduleinst)
    allnames    = [ n for n in names( moduleinst ) ]
    nv          = length( allnames )
    graph       = SimpleDiGraph( nv )
    tags        = Dict( 1:nv .=> allnames )
    lookup      = Dict( allnames .=> 1:nv )
    #remove package name from list
    allnames    = allnames[ allnames .!= modname ]
    fns         = [ safeisfield(moduleinst, curname, Function ) for curname in allnames ]
    types       = [ safeisnotabstract(moduleinst, curname, Type ) && !(string(curname)[1] == '@') for curname in allnames]
    abstypes    = [ safeisabstract(moduleinst, curname, Type ) && !(string(curname)[1] == '@') for curname in allnames]
    others      = (fns .+ types) .== 0
    return Detective(   moduleinst, modname, allnames,
                        allnames[fns], allnames[types], allnames[abstypes], allnames[others],
                        graph, nv, tags, lookup )
end
