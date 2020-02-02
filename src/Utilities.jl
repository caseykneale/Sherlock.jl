function typetype_graph( sher::Detective )
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

function functiontype_graph( sher::Detective )
    
end
