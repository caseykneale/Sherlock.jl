using Pkg
Pkg.API.develop(Pkg.PackageSpec(name="MrPhelps", path="/home/caseykneale/Desktop/Playground/MrPhelps/"))
using MrPhelps

sherlock = Sherlock( MrPhelps )
buildgraph( sherlock )
Plots.default(size = (1000, 1000))

#borrowed from graph recipes
graphplot(sherlock.graph,
          markersize = 0.065,
          markercolor = range(colorant"lightblue", stop=colorant"lightgreen", length=sherlock.nv),
          names = [ sherlock.tag[i] for i in 1:sherlock.nv ] ,
          fontsize = 10,
          linecolor = :darkgrey,
          title = "Sherlock Type Graph: $(sherlock.modulename)"
          )

#png("/home/caseykneale/Desktop/Sherlock/pics/mrphelps.png")
