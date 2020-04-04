@enum ENTITY_TYPES begin
    is_function         = 1
    is_type             = 2
    is_abstract_type    = 3
    is_untyped          = 4
    not_found           = 5
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

"""
    functions(d::Detective)::Vector{Symbol}

Returns a list of functions of a module in a `Detective` object.

"""
functions(d::Detective)::Vector{Symbol} = d.functions

"""
    types(d::Detective)::Vector{Symbol}

Returns a list of types of a module in a `Detective` object.

"""
types(d::Detective)::Vector{Symbol} = d.types

"""
    abstracttypes(d::Detective)::Vector{Symbol}

Returns a list of abstract types of a module in a `Detective` object.

"""
abstracttypes(d::Detective)::Vector{Symbol} = d.abstracttypes

"""
    undefined(d::Detective)::Vector{Symbol}

Returns a list of undefined objects in a module in a `Detective` object.
This could be exported items that don't exist, or objects without explicit types,
until compile time.

"""
undefined(d::Detective)::Vector{Symbol} = d.undefined_exports

"""
    inquire( d::Detective, s::Union{Symbol,String} )

This function will search a loaded module for an instance or method of symbol `s`.
If it finds it, it will, return an enumeration of its category. This is useful
for quickly categorizing an item in a struct for display purposes.

"""
function inquire( d::Detective, s::Union{Symbol,String} )::Union{Nothing, ENTITY_TYPES}
    if isa(s, String)
        s = Symbol(s)
    end
    typeis = nothing
    if s in d.types
        typeis = is_type
    elseif s in d.functions
        typeis = is_function
    elseif s in d.abstracttypes
        typeis = is_abstract_type
    elseif s in d.undefined_exports
        typeis = is_untyped
    else
        typeis = not_found
    end
    return typeis
end

function safeisfield(m::Module, s::Symbol, t::Type)::Bool
    try
        return isa( getfield(m, s) , t)
    catch
        return false
    end
end

function safeisnotabstract(m::Module, s::Symbol, t::Type)::Bool
    return safeisfield( m, s, t ) && !isabstracttype( getfield( m, s ) )
end

function safeisabstract(m::Module, s::Symbol, t::Type)::Bool
    return safeisfield( m, s, t ) && isabstracttype( getfield( m, s ) )
end

"""
    ismacro(s::Symbol)

checks the first character of an input symbol to see if it contains a `@` or not.

"""
ismacro(s::Symbol) = first( string( s ) ) == '@'

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
    types       = [ safeisnotabstract(moduleinst, curname, Type ) && !ismacro(curname) for curname in allnames]
    #remove constructors from functions?
    fns[fns .& types ] .= false
    abstypes    = [ safeisabstract(moduleinst, curname, Type ) && !ismacro(curname) for curname in allnames]
    others      = (fns .+ types .+ abstypes) .== 0
    return Detective(   moduleinst, modname, allnames,
                        allnames[fns], allnames[types], allnames[abstypes], allnames[others],
                        graph, nv, tags, lookup )
end
