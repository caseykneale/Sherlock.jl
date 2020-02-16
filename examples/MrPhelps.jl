using Pkg

Pkg.update()

using LightGraphs, GraphRecipes, Plots
Pkg.API.develop(Pkg.PackageSpec(name="MrPhelps", path="/home/caseykneale/Desktop/Playground/MrPhelps/"))
using MrPhelps
Pkg.API.develop(Pkg.PackageSpec(name="Sherlock", path="/home/caseykneale/Desktop/Sherlock.jl/"))
using Sherlock

d = Detective( Sherlock )
typetype_edges(d)
functiontype_edges(d)

functions(d)
types(d)

abstracttypes(d)
undefined(d)

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
plot( type_in, method=:tree, fontsize=10, nodeshape=:rect)

# cool = Observable{Any}([])
# cool[] = plot( type_in, method=:tree, fontsize=10, nodeshape=:rect)
#
