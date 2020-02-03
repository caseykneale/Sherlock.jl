using Pkg
#Pkg.API.develop(Pkg.PackageSpec(name="MrPhelps", path="/home/caseykneale/Desktop/Playground/MrPhelps/"))
using MrPhelps
#Pkg.API.develop(Pkg.PackageSpec(name="Sherlock", path="/home/caseykneale/Desktop/Sherlock.jl/"))
using Sherlock

sherlock = Detective( MrPhelps )
typetype_graph( sherlock )

functions(sherlock)
types(sherlock)
abstracttypes(sherlock)
undefined(sherlock)
using LightGraphs

#typetype_graph(sherlock)
functiontype_graph(sherlock)
inquire( sherlock, :FileIterator )
inquire( sherlock, Symbol("Thunk") )
#borrowed from graph recipes - will be updated
using Plots, GraphRecipes
Plots.default( size = (1400, 1400) )
graphplot(sherlock.graph,
          markersize = 0.025,
          markercolor = range(colorant"lightblue", stop=colorant"lightgreen", length=sherlock.nv),
          names = [ sherlock.tag[i] for i in 1:sherlock.nv ] ,
          fontsize = 12,
          linecolor = :black,
          title = "Sherlock Function to Type Graph: $(sherlock.modulename)" )

png("/home/caseykneale/Desktop/Sherlock.jl/images/mrphelpsfnmaps.png")
