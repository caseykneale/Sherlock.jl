using Pkg
#Pkg.API.develop(Pkg.PackageSpec(name="MrPhelps", path="/home/caseykneale/Desktop/Playground/MrPhelps/"))
using MrPhelps
Pkg.API.develop(Pkg.PackageSpec(name="Sherlock", path="/home/caseykneale/Desktop/Sherlock.jl/"))
using Sherlock

sherlock = Detective( Sherlock )
typetype_edges(sherlock)
functiontype_edges(sherlock)

functions(sherlock)
types(sherlock)
abstracttypes(sherlock)
undefined(sherlock)
#using LightGraphs, Plots

#Plots.default(size = (500,500))

inquire( sherlock, :FileIterator )
inquire( sherlock, Symbol("Thunk") )

#magnify( sherlock, :Detective )
#magnify( sherlock, :NodeManager )

#Borrowed from graph recipes - will be updated
#using Plots, GraphRecipes, Blink, Interact
#Plots.default( size = (800, 800) )

sherlock_UI()
