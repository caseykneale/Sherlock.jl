module Sherlock

# Usings and imports
using Blink
using GraphRecipes
using Interact
using InteractiveUtils
using LightGraphs
using Plots

# Exports: types.jl
export abstracttypes
export Detective
export ENTITY_TYPES
export functions
export inquire
export ismacro
export safeisabstract
export safeisfield
export safeisnotabstract
export types
export undefined

# Exports: utilities.jl
export functiontype_edges
export greet
export nothing_is_val
export trim_type
export typetype_edges
#pkgchildren, loaded_packages #irreprable error with these...

# Exports: visualizations.jl
export magnify
export MIMO
export sherlockplot
export sherlock_UI
export typetree

# Includes
include("types.jl")
include("utilities.jl")
include("visualizations.jl")

end # module
