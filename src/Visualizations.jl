function magnify( d::Detective, s::Symbol)
    if haskey(d.lookup, s)
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
                curvature_scalar = 0.0, nodesize = 0.07,
                names = names, nodecolor = :lightgray, color = :black,
                nodeshape = :rect, fontsize = 10 )
    else
        return "Key $s not found..."
    end
end

function sherlockplot(d::Detective)
    try
        colormap = Dict( is_function => :lightblue, is_type => :lightgreen,
                is_abstract_type => :lightred, is_untyped => :lightpurple, not_found => :grey )

        [ colormap[ inquire( d, v ) ] for (k,v) in d.tag ]

        return graphplot(d.graph,
                size = (1000,800),
                  markersize = 0.111,
                  nodeshape = :rect,
                  markercolor = [ colormap[ inquire( d, v ) ] for (k,v) in d.tag ],
                  #range(colorant"lightblue", stop=colorant"lightgreen", length=d.nv),
                  names = [ d.tag[i] for i in 1:d.nv ] ,
                  fontsize = 10,
                  linecolor = :black,
                  title = "Sherlock Graph: $(d.modulename)" )
    catch
        return "No edges/connections found..."
    end
end

function sherlock_UI()
    module_lbl = "Module Name: ";
    available_modules = Observable{String}( "Sherlock" )
    module_txt = Widgets.textbox( available_modules[] );
    module_btn = Widgets.button( "Inspect" );
    throttle(0.05, module_btn)

    types_to_functions = Widgets.toggle(true; label = "Types 🡆 Functions");
    functions_to_functions = Widgets.toggle(true; label = "Functions 🡆 Functions");
    views = vbox( types_to_functions, functions_to_functions );
    topload = hbox( pad(1em, module_lbl), pad(1em, module_txt), views, pad(1em, module_btn) );

    graphdisplay = Observable{Any}("Please Inspect a Module...");

    mainwindow = vbox(  topload, graphdisplay );
    sherlock = Observable( Detective( Sherlock ) )

    function make_graph( d, selected_module::Symbol,
                        types_to_fns, fns_to_fns )
        try
            if (types_to_fns || fns_to_fns)
                d = Detective( getfield(Main, selected_module) )
                if types_to_fns; typetype_edges(d); end
                if fns_to_fns  ; functiontype_edges(d); end
                focus_lbl       = "Focus On: "
                focus_btn       = Widgets.button( "Focus" );
                focus_txt       = Widgets.dropdown( vcat(types(d), functions(d)) );
                focus_frame     = vbox( hbox( pad(1em, focus_lbl), pad(1em, focus_txt), pad(1em, focus_btn) ) );
                throttle(0.05, focus_btn)
                map!( x -> vbox( Interact.hline(), focus_frame, magnify( d, Symbol(focus_txt[]) ) ),
                                graphdisplay, focus_btn)

                return vbox( Interact.hline(), focus_frame, sherlockplot(d))
            else
                return "Please Choose a Module or a View..."
            end
        catch
            return "Module does not exist."
        end
    end
    map!( x -> make_graph(sherlock[], Symbol(module_txt[]), types_to_functions[], functions_to_functions[]),
                        graphdisplay, module_btn)

    w = Window( async = true )
    body!( w, mainwindow, async = true )
    return w
end
