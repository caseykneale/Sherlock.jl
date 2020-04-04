module Sherlock
    using Plots, LightGraphs, GraphRecipes, InteractiveUtils, Blink, Interact
    greet() = print("My mind rebels at stagnation, give me problems, give me work!")

    include("Types.jl")
    export ENTITY_TYPES, Detective, functions, types, abstracttypes,
        undefined, inquire, safeisfield, safeisabstract,
        safeisnotabstract, ismacro

    include("Utilities.jl")
    export nothing_is_val, trim_type, typetype_edges, functiontype_edges
            #pkgchildren, loaded_packages #irreprable error with these...

    include("Visualizations.jl")
    export magnify, MIMO, typetree, sherlockplot, sherlock_UI

end # module
