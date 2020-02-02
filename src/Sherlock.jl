module Sherlock
    using LightGraphs, GraphRecipes, Plots

    #greet() = print("")

    include("Types.jl")
    export ENTITY_TYPES, Detective, functions, types, abstracttypes,
    undefined, inquire, safeisfield, safeisabstract, safeisnotabstract

    include("Utilities.jl")
    export build_typetype_graph

end # module
