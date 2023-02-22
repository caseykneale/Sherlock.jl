"""
    typetree( s::Symbol )

Returns a subgraph type tree plot of a given type

This is literally a wrapper for basic GraphRecipes functionality.

"""
function typetree(d::Detective, s::Symbol)
    type_in = getfield(d.moduleinst, s)
    return plot(
        type_in;
        method=:tree,
        color=:black,
        nodesize=0.07,
        nodecolor=:lightgray,
        fontsize=10,
        nodeshape=:rect,
    )
end

"""
    magnify( d::Detective, s::Symbol)

Returns a subgraph plot of the first order interactions of a
 given object in a `Detective` instance.

"""
function magnify(d::Detective, s::Symbol, style::Symbol = :MIMO)
    if style == :MIMO
        return MIMO(d, s)
    elseif style == Symbol("Type Tree")
        return typetree(d, s)
    else #This shouldn't happen... ever...
        @error("Plot style($style) requested, not recognized.")
    end
end

"""
    MIMO( d::Detective, s::Symbol)

Returns a subgraph plot of the first order interactions of a
 given object in a `Detective` instance.

"""
function MIMO(d::Detective, s::Symbol)
    if haskey(d.lookup, s)
        ndx = d.lookup[s]
        innb, outnb = inneighbors(d.graph, ndx), outneighbors(d.graph, ndx)
        if (length(innb) + length(outnb)) > 0
            subgraph = SimpleDiGraph(length(unique(vcat(innb, outnb))) + 1)

            for (nb, v) in enumerate(innb)
                add_edge!(subgraph, nb, length(innb) + 1)
            end
            for (nb, v) in enumerate(outnb)
                add_edge!(subgraph, length(innb) + 1, length(innb) + 1 + nb)
            end
            names = vcat([d.tag[i] for i in innb], s, [d.tag[o] for o in outnb])
            x = vcat([0.0 for i in 1:length(innb)], 0.5, [1.0 for o in 1:length(outnb)])
            y = vcat(
                [(i - 1) / (length(innb) - 1) for i in 1:length(innb)],
                0.5,
                [(o - 1) / (length(outnb) - 1) for o in 1:length(outnb)],
            )

            return graphplot(
                subgraph;
                x=x,
                y=y,
                curvature_scalar=0.05,
                nodesize=0.08,
                names=names,
                nodecolor=:lightgray,
                color=:black,
                nodeshape=:rect,
                fontsize=10,
            )
        else
            return "Selected item has no found connections..."
        end
    else
        return "Key $s not found..."
    end
end

"""
    sherlockplot(d::Detective)

Returns a LightGraphs plot recipe of a `Detective` instances internal graph.

"""
function sherlockplot(d::Detective)
    try
        l = @layout [a{0.05h}; b]

        p1 = scatter(
            [0, 1, 2, 3, 4],
            [0, 0, 0, 0, 0];
            markershape=:rect,
            xlim=[-1.65, 5.65],
            ylim=[-0.01, 0.01],
            legend=false,
            axis=nothing,
            ticks=nothing,
            markerstrokecolor=:white,
            border=:none,
            markersize=45,
            size=(999, 70),
            markercolor=[:lightblue, :lightgreen, :tomato, :orchid1, :grey],
            title="$(string(d.modulename)) Overview",
        )
        annotate!(p1, [0.0], [0.00], "Function")
        annotate!(p1, [1.0], [0.00], "Type")
        annotate!(p1, [2.0], [0.00], "Abstract")
        annotate!(p1, [3.0], [0.00], "Dynamic")
        annotate!(p1, [4.0], [0.00], "Unknown")

        colormap = Dict(
            is_function => :lightblue,
            is_type => :lightgreen,
            is_abstract_type => :tomato,
            is_untyped => :orchid1,
            not_found => :grey,
        )

        colors = [colormap[inquire(d, v)] for (k, v) in d.tag]
        colororder = sortperm([k for (k, _) in d.tag])
        p2 = graphplot(
            d.graph;
            size=(999, 999),
            markersize=0.111,
            nodeshape=:rect,
            markercolor=colors[colororder],
            names=[d.tag[i] for i in 1:(d.nv)],
            fontsize=10,
            linecolor=:black,
        )
        return plot(p1, p2; layout=l)
    catch
        return "No edges/connections found..."
    end
end

"""
    sherlock_UI()

This is a convenience function to create a Blink window which hosts an Interact
UI. The intention of the UI is to explore a module (typed in by a user), and display
some of the knowledge obtained about it graphically.

"""
function sherlock_UI()
    module_lbl = "Module Name: "
    available_modules = Observable{String}("Sherlock")
    module_txt = Widgets.textbox(available_modules[])
    module_btn = Widgets.button("Inspect")
    types_to_functions = Widgets.toggle(true; label="Types -> Functions")
    functions_to_functions = Widgets.toggle(true; label="Functions -> Functions")
    views = vbox(types_to_functions, functions_to_functions)
    topload = hbox(pad(1em, module_lbl), pad(1em, module_txt), views, pad(1em, module_btn))

    graphdisplay = Observable{Any}(
        plot(
            [0.0],
            [0.0];
            color=:white,
            border=:none,
            legend=false,
            axis=nothing,
            ticks=nothing,
            title="Please Inspect a Module that is Loaded into Scope. \n Inspection may require 30s for the first run.",
        ),
    )
    mainwindow = vbox(topload, graphdisplay)
    sherlock = Observable(Detective(Sherlock))

    function make_graph(d, selected_module::Symbol, types_to_fns, fns_to_fns)
        try
            if (types_to_fns || fns_to_fns)
                d = Detective(getfield(Main, selected_module))
                if types_to_fns
                    typetype_edges(d)
                end
                if fns_to_fns
                    functiontype_edges(d)
                end
                focus_lbl = "Focus On: "
                focus_options = radiobuttons(["MIMO", "Type Tree"])
                focus_btn = Widgets.button("Focus")
                #get types and functions which have connections
                ts = vcat(d.types, d.abstracttypes)
                fs = d.functions
                nbs = [LightGraphs.neighbors(d.graph, d.lookup[f]) for f in fs]
                fs = fs[length.(nbs) .> 0]
                focus_txt = Widgets.dropdown(vcat(ts, fs))
                focus_frame = vbox(
                    hbox(
                        pad(1em, focus_lbl),
                        pad(1em, focus_txt),
                        pad(1em, focus_options),
                        pad(1em, focus_btn),
                    ),
                )
                map!(
                    x -> vbox(
                        Interact.hline(),
                        focus_frame,
                        magnify(d, Symbol(focus_txt[]), Symbol(focus_options[])),
                    ),
                    graphdisplay,
                    focus_btn,
                )
                return vbox(Interact.hline(), focus_frame, sherlockplot(d))
            else
                return "Please Choose a Module or a View..."
            end
        catch
            return "Module not found, does not exist, or serious error occurred!"
        end
    end
    map!(
        x -> make_graph(
            sherlock[],
            Symbol(module_txt[]),
            types_to_functions[],
            functions_to_functions[],
        ),
        graphdisplay,
        module_btn,
    )

    w = Window(; async=true)
    body!(w, mainwindow; async=true)
    return w
end
