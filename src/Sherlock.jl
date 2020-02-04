module Sherlock
    using InteractiveUtils, LightGraphs, GraphRecipes, Plots
    greet() = print("My mind rebels at stagnation, give me problems, give me work!")

    include("Types.jl")
    export ENTITY_TYPES, Detective, functions, types, abstracttypes,
        undefined, inquire, safeisfield, safeisabstract,
        safeisnotabstract

    include("Utilities.jl")
    export typetype_edges, functiontype_edges

    include("Visualizations.jl")
    export magnify

end # module
