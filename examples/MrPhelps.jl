using Pkg
Pkg.API.develop(Pkg.PackageSpec(name="MrPhelps", path="/home/caseykneale/Desktop/Playground/MrPhelps/"))
using MrPhelps
Pkg.API.develop(Pkg.PackageSpec(name="Sherlock", path="/home/caseykneale/Desktop/Sherlock.jl/"))
using Sherlock


sherlock = Detective( MrPhelps )
build_typetype_graph( sherlock )
Plots.default( size = (800, 800) )

#borrowed from graph recipes - will be updated
using Plots, GraphRecipes
graphplot(sherlock.graph,
          markersize = 0.065,
          markercolor = range(colorant"lightblue", stop=colorant"lightgreen", length=sherlock.nv),
          names = [ sherlock.tag[i] for i in 1:sherlock.nv ] ,
          fontsize = 10,
          linecolor = :darkgrey,
          title = "Sherlock Type Graph: $(sherlock.modulename)" )

#png("/home/caseykneale/Desktop/Sherlock/pics/mrphelps.png")
