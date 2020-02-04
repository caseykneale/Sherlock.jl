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

function functiontype_edges( d::Detective )
    for stype in d.types
        thisnode = d.lookup[stype]
        nodefield = getfield( d.moduleinst, stype )
        #methodswith( Scheduler )
        for method in InteractiveUtils.methodswith( getfield( d.moduleinst, stype ), d.moduleinst )
            getfn = method.name
            add_edge!( d.graph, thisnode, d.lookup[ Symbol( getfn ) ] )
        end
    end
end
