function magnifye( d::Detective, s::Symbol)
    ndx = d.lookup[ s ]
    innb, outnb = inneighbors( d.graph, ndx), outneighbors( d.graph, ndx)
    subgraph = SimpleDiGraph( length( unique( vcat(innb, outnb ) ) ) + 1 )

    for (nb, v) in enumerate( innb )
        add_edge!(subgraph, nb, length( innb ) + 1)
    end
    for (nb, v) in enumerate( outnb )
        add_edge!(subgraph, length( innb ) + 1, length( innb ) + 1 + nb)
    end

    names = vcat( [ d.tag[ i ] for i in innb],
                 s, [ d.tag[ o ] for o in outnb] )
    x = vcat( [ 0.0 for i in 1:length(innb)],
            0.5, [ 1.0 for o in 1:length(outnb)] )
    y = vcat( [ (i-1)/(length(innb)-1) for i in 1:length(innb)],
        0.5, [ (o-1)/(length(outnb)-1) for o in 1:length(outnb)] )

    return graphplot(subgraph, x=x, y=y,
            curvature_scalar = 0.0, nodesize = 0.03,
            names = names, nodecolor = :lightgray, color = :black,
            nodeshape = :rect, fontsize = 18 )
end
