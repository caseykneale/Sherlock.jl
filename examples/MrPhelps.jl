using Pkg
#Pkg.API.develop(Pkg.PackageSpec(name="MrPhelps", path="/home/caseykneale/Desktop/Playground/MrPhelps/"))
using MrPhelps
#Pkg.API.develop(Pkg.PackageSpec(name="Sherlock", path="/home/caseykneale/Desktop/Sherlock.jl/"))
using Sherlock

sherlock = Detective( MrPhelps )
typetype_graph(sherlock)
functiontype_graph(sherlock)

functions(sherlock)
types(sherlock)
abstracttypes(sherlock)
undefined(sherlock)
using LightGraphs, Plots

Plots.default(size = (500,500))

inquire( sherlock, :FileIterator )
inquire( sherlock, Symbol("Thunk") )


magnify( sherlock, :Scheduler )
magnify( sherlock, :NodeManager )

#borrowed from graph recipes - will be updated
using Plots, GraphRecipes
Plots.default( size = (1400, 1400) )
graphplot(sherlock.graph,
          markersize = 0.035,
          nodeshape = :rect,
          markercolor = range(colorant"lightblue", stop=colorant"lightgreen", length=sherlock.nv),
          names = [ sherlock.tag[i] for i in 1:sherlock.nv ] ,
          fontsize = 12,
          linecolor = :black,
          title = "Sherlock Function to Type Graph: $(sherlock.modulename)" )

png("/home/caseykneale/Desktop/Sherlock.jl/images/mrphelpsfnmaps.png")

using RecipesBase, Plots

struct Node
    txt::String
    x::Float64
    y::Float64
    fontsize::Int
end

@recipe function plot(z::Node)
    w, h = ( 20, 20 )
    seriestype := :shape
    @series begin
        color := :lightgrey
        y := ( z.x .+ [ 0-w, w, w, 0-w ], z.y .+ [ 0-h, 0-h, 0, 0 ] .- 2 )
    end
end

function make_element( n::Node ; fontsize = 20)
    plt = plot( n, legend = false )
    annotate!( plt, n.x, n.y, text(n.txt, :black, :right, fontsize ) )
    return plt
end

z = Node("cookies", 10, 10, 20)
make_element(z)
