using Pkg
#Pkg.API.develop(Pkg.PackageSpec(name="Sherlock", path="/home/caseykneale/.julia/dev/Sherlock"))

using Sherlock
using MonteCarloMeasurements
Pkg.add("Simple")
using SimpleWeightedGraphs

d = Detective( MonteCarloMeasurements )
typetype_edges( d )
functiontype_edges( d )

functions( d )
types( d )

getfield( MonteCarloMeasurements, :AbstractParticles )

abstracttypes( d )
undefined( d )

#sherlockplot(d)
Plots.default(size = (1000,1000))
#inquire( d, :FileIterator )
#inquire( d, Symbol("Thunk") )
#magnify( d, :Detective )
#magnify( d, :NodeManager )
#using Plots, GraphRecipes, Blink, Interact
sherlock_UI()



using GraphRecipes, Plots, Interact
type_in = getfield( Sherlock, :Detective )
plot( type_in, method=:tree, fontsize=10, nodeshape=:rect,
    nodesize = 0.07, nodecolor = :lightgray, color = :black )

# cool = Observable{Any}([])
# cool[] = plot( type_in, method=:tree, fontsize=10, nodeshape=:rect)
#
