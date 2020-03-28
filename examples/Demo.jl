#using Pkg
#Pkg.API.develop(Pkg.PackageSpec(name="Sherlock", path="/home/caseykneale/.julia/dev/Sherlock"))

using Sherlock
sherlock_UI()

using MonteCarloMeasurements
#Pkg.add("Simple")
#using SimpleWeightedGraphs

d = Detective( Sherlock )
typetype_edges( d )
functiontype_edges( d )

functions( d )
types( d )
abstracttypes( d )
undefined( d )

#sherlockplot(d)
#Plots.default(size = (1000,1000))
inquire( d, :Detective )

colors = [ k => (v, inquire( d, v ))  for (k,v) in d.tag ]
d.tag
d.graph

#inquire( d, Symbol("Thunk") )
#magnify( d, :Detective )
#magnify( d, :NodeManager )
#using Plots, GraphRecipes, Blink, Interact
sherlock_UI()




using Plots
l = @layout [a ; b ]

p1 = scatter( [ 0,1,2,3,4 ],[ 0,0,0,0,0 ], markershape = :rect,
            xlim = [ -0.45, 4.45 ], ylim = [ -0.01, 0.01 ],
            legend = false, axis = nothing, ticks = nothing,
            border = :none, markersize = 30,
            size = (640,96),
            markercolor = [ :lightblue, :lightgreen, :tomato,
                            :orchid1, :grey]
            )
annotate!(p1, [0.0], [0.00], "Function" )
annotate!(p1, [1.0], [0.00], "Type"     )
annotate!(p1, [2.0], [0.00], "Abstract" )
annotate!(p1, [3.0], [0.00], "Untyped"  )
annotate!(p1, [4.0], [0.00], "???"      )

p2 = scatter(randn(100,2))
plot(p1, p2, layout = l)


using GraphRecipes, Plots, Interact
type_in = getfield( Sherlock, :Detective )
plot( type_in, method=:tree, fontsize=10, nodeshape=:rect,
    nodesize = 0.07, nodecolor = :lightgray, color = :black )

# cool = Observable{Any}([])
# cool[] = plot( type_in, method=:tree, fontsize=10, nodeshape=:rect)
#
