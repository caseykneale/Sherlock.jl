nothing_is_val( x::Union{Nothing,Int}, val = Inf ) = isnothing(x) ? val : x

"""
    trim_type( s::Symbol )::Symbol

Trims a type Symbol to the first `{`, or ` `. Also takes the last subtype after a `.`.

"""
function trim_type( s::Symbol )::Symbol
    super_str = String( s )
    super_chr = collect(super_str)
    super_len = length( super_str )
    firstbra = nothing_is_val( findfirst( super_chr .== '{' ), super_len )
    firstspace = nothing_is_val( findfirst( super_chr .== ' '), super_len )
    nearest = clamp( min(firstbra, firstspace), 1, super_len)
    if nearest < super_len
        nearest -= 1
    end
    super_str = last(split(super_str[ 1:nearest ],"."))
    return Symbol(super_str)
end

#unfortunately this explodes when run from a package? :'(
#https://stackoverflow.com/questions/25575406/list-of-loaded-imported-packages-in-julia
#pkgchildren(m::Module) = filter((x) -> typeof(eval(x)) <:  Module && x ≠ :Main, names(Main,imported=true))
#loaded_packages() = pkgchildren(Main)
"""
    typetype_edges( d::Detective )

Discovers first order relationships between types in a package.
It adds that information to a `Detective` instance's internal
graph object as an inplace operation.

"""
function typetype_edges( sher::Detective )
    #Dive into the types to look for type relationships
    for stype in sher.types
        thisnode = sher.lookup[stype]
        nodefield = getfield( sher.moduleinst, stype )
        for subtype in fieldtypes( nodefield )
            if subtype in [ getfield( sher.moduleinst, st ) for st in sher.types]
                add_edge!( sher.graph, sher.lookup[ Symbol( subtype ) ], thisnode )
            end
        end
        #map parent abstract type to types if they are exclusive to the module.
        super = trim_type( Symbol( supertype(nodefield) ) )
        if super in sher.abstracttypes
            add_edge!( sher.graph, sher.lookup[ super ], thisnode )
        end
    end
end

"""
    functiontype_edges( d::Detective )

Discovers which types are called from the available functions
in a package. It adds that information to a `Detective` instance's
internal graph object as an inplace operation.

"""
function functiontype_edges( d::Detective )
    for stype in d.types
        thisnode = d.lookup[stype]
        nodefield = getfield( d.moduleinst, stype )
        for method in InteractiveUtils.methodswith( getfield( d.moduleinst, stype ), d.moduleinst )
            getfn = method.name
            add_edge!( d.graph, thisnode, d.lookup[ Symbol( getfn ) ] )
        end
    end
end
