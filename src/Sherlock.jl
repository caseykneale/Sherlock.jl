module Sherlock
    using Plots, LightGraphs, GraphRecipes, InteractiveUtils, Blink, Interact
    greet() = print("My mind rebels at stagnation, give me problems, give me work!")

    include("Types.jl")
    export ENTITY_TYPES, Detective, functions, types, abstracttypes,
        undefined, inquire, safeisfield, safeisabstract,
        safeisnotabstract

    include("Utilities.jl")
    export typetype_edges, functiontype_edges
            #pkgchildren, loaded_packages #irreprable error with these...

    include("Visualizations.jl")
    export magnify, MIMO, typetree, sherlockplot, sherlock_UI

end # module
