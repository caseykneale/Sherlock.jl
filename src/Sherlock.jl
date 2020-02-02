module Sherlock
    using LightGraphs, GraphRecipes, Plots

    #greet() = print("")

    include("Types.jl")
    export Sherlock, safeisfield, safeisabstract, safeisnotabstract

    include("Utilities.jl")
    export build_typetype_graph

end # module
