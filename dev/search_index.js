var documenterSearchIndex = {"docs":
[{"location":"#Sherlock.jl","page":"Home","title":"Sherlock.jl","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"","category":"page"},{"location":"","page":"Home","title":"Home","text":"Modules = [Sherlock]","category":"page"},{"location":"#Sherlock.Detective-Tuple{Module}","page":"Home","title":"Sherlock.Detective","text":"Detective( moduleinst::Module )\n\nInstantiate Detective object via a module.\n\n\n\n\n\n","category":"method"},{"location":"#Sherlock.MIMO-Tuple{Detective, Symbol}","page":"Home","title":"Sherlock.MIMO","text":"MIMO( d::Detective, s::Symbol)\n\nReturns a subgraph plot of the first order interactions of a  given object in a Detective instance.\n\n\n\n\n\n","category":"method"},{"location":"#Sherlock.abstracttypes-Tuple{Detective}","page":"Home","title":"Sherlock.abstracttypes","text":"abstracttypes(d::Detective)::Vector{Symbol}\n\nReturns a list of abstract types of a module in a Detective object.\n\n\n\n\n\n","category":"method"},{"location":"#Sherlock.functions-Tuple{Detective}","page":"Home","title":"Sherlock.functions","text":"functions(d::Detective)::Vector{Symbol}\n\nReturns a list of functions of a module in a Detective object.\n\n\n\n\n\n","category":"method"},{"location":"#Sherlock.functiontype_edges-Tuple{Detective}","page":"Home","title":"Sherlock.functiontype_edges","text":"functiontype_edges( d::Detective )\n\nDiscovers which types are called from the available functions in a package. It adds that information to a Detective instance's internal graph object as an inplace operation.\n\n\n\n\n\n","category":"method"},{"location":"#Sherlock.greet-Tuple{}","page":"Home","title":"Sherlock.greet","text":"greet()\n\nPrint \"My mind rebels at stagnation, give me problems, give me work!\".\n\n\n\n\n\n","category":"method"},{"location":"#Sherlock.inquire-Tuple{Detective, Symbol}","page":"Home","title":"Sherlock.inquire","text":"inquire( d::Detective, s::Union{Symbol,String} )\n\nThis function will search a loaded module for an instance or method of symbol s. If it finds it, it will, return an enumeration of its category. This is useful for quickly categorizing an item in a struct for display purposes.\n\n\n\n\n\n","category":"method"},{"location":"#Sherlock.ismacro-Tuple{Symbol}","page":"Home","title":"Sherlock.ismacro","text":"ismacro(s::Symbol)\n\nchecks the first character of an input symbol to see if it contains a @ or not.\n\n\n\n\n\n","category":"method"},{"location":"#Sherlock.magnify-Tuple{Detective, Symbol, Symbol}","page":"Home","title":"Sherlock.magnify","text":"magnify( d::Detective, s::Symbol)\n\nReturns a subgraph plot of the first order interactions of a  given object in a Detective instance.\n\n\n\n\n\n","category":"method"},{"location":"#Sherlock.nothing_is_val","page":"Home","title":"Sherlock.nothing_is_val","text":"nothing_is_val( x::Union{Nothing,Int}, val = Inf )\n\nif x is a type nothing return the alternative, val param. Otherwise returns x. Note: this is specifically used for findfirst() failures internally.\n\n\n\n\n\n","category":"function"},{"location":"#Sherlock.sherlock_UI-Tuple{}","page":"Home","title":"Sherlock.sherlock_UI","text":"sherlock_UI()\n\nThis is a convenience function to create a Blink window which hosts an Interact UI. The intention of the UI is to explore a module (typed in by a user), and display some of the knowledge obtained about it graphically.\n\n\n\n\n\n","category":"method"},{"location":"#Sherlock.sherlockplot-Tuple{Detective}","page":"Home","title":"Sherlock.sherlockplot","text":"sherlockplot(d::Detective)\n\nReturns a LightGraphs plot recipe of a Detective instances internal graph.\n\n\n\n\n\n","category":"method"},{"location":"#Sherlock.trim_type-Tuple{Symbol}","page":"Home","title":"Sherlock.trim_type","text":"trim_type( s::Symbol )::Symbol\n\nTrims a type Symbol to the first {, or . Also takes the last subtype after a ..\n\n\n\n\n\n","category":"method"},{"location":"#Sherlock.types-Tuple{Detective}","page":"Home","title":"Sherlock.types","text":"types(d::Detective)::Vector{Symbol}\n\nReturns a list of types of a module in a Detective object.\n\n\n\n\n\n","category":"method"},{"location":"#Sherlock.typetree-Tuple{Detective, Symbol}","page":"Home","title":"Sherlock.typetree","text":"typetree( s::Symbol )\n\nReturns a subgraph type tree plot of a given type\n\nThis is literally a wrapper for basic GraphRecipes functionality.\n\n\n\n\n\n","category":"method"},{"location":"#Sherlock.typetype_edges-Tuple{Detective}","page":"Home","title":"Sherlock.typetype_edges","text":"typetype_edges( d::Detective )\n\nDiscovers first order relationships between types in a package. It adds that information to a Detective instance's internal graph object as an inplace operation.\n\n\n\n\n\n","category":"method"},{"location":"#Sherlock.undefined-Tuple{Detective}","page":"Home","title":"Sherlock.undefined","text":"undefined(d::Detective)::Vector{Symbol}\n\nReturns a list of undefined objects in a module in a Detective object. This could be exported items that don't exist, or objects without explicit types, until compile time.\n\n\n\n\n\n","category":"method"}]
}
