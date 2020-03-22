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
                add_edge!( sher.graph, sher.lookup[ Symbol( subtype ) ] , thisnode )
            end
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
