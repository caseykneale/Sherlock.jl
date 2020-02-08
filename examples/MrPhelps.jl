using Pkg
Pkg.API.develop(Pkg.PackageSpec(name="MrPhelps", path="/home/caseykneale/Desktop/Playground/MrPhelps/"))
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

#inquire( sherlock, :FileIterator )
#inquire( sherlock, Symbol("Thunk") )

#magnify( sherlock, :Detective )
#magnify( sherlock, :NodeManager )

# magnify( sherlock, :abstracttypes )
# magnify( sherlock, :types )
# magnify( sherlock, :abstracttypes )

#using Plots, GraphRecipes, Blink, Interact
sherlock_UI()



using Pkg
Pkg.update()
using Flux

flatten(x) = reshape(x, :, size(x, 4))

stop_gradient(x) = x
Flux.@nograd stop_gradient

function main()

    #Let's make a model....
    obs, vars       = ( 10, 200 )
    proxydata = randn(vars, 1, 1, obs)

    model = Chain(Conv( ( 5, 1 ),  1 => 16, relu),
                  Conv( ( 5, 1 ),  16 => 24, relu),
                  # stop_gradient,
                  x -> reshape(x, :, size(x, 4)),
                  Dense( 4608, 32,  relu ),
                  Dense( 32, 32,  relu ),
                  Dense( 32, 1, relu ))

    println(model(proxydata))
    mseloss( x1, y1 ) = sum( model( x1 ) .- y1 )
    Flux.gradient(()->mseloss(proxydata, randn(1,10)), Flux.params(model))

end

main()
