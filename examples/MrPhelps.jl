pkgchildren2(m::Module) = filter((x) -> typeof(eval(x)) <:  Module && x ≠ :Main, names(Main,imported=true))

using Pkg
#Pkg.API.develop(Pkg.PackageSpec(name="MrPhelps", path="/home/caseykneale/Desktop/Playground/MrPhelps/"))
using MrPhelps
Pkg.API.develop(Pkg.PackageSpec(name="Sherlock", path="/home/caseykneale/Desktop/Sherlock.jl/"))
using Sherlock

sherlock = Detective( MrPhelps )
typetype_edges(sherlock)
functiontype_edges(sherlock)

functions(sherlock)
types(sherlock)
abstracttypes(sherlock)
undefined(sherlock)
using LightGraphs, Plots

Plots.default(size = (500,500))

inquire( sherlock, :FileIterator )
inquire( sherlock, Symbol("Thunk") )

#magnify( sherlock, :Scheduler )
#magnify( sherlock, :NodeManager )

#borrowed from graph recipes - will be updated
using Plots, GraphRecipes, Blink, Interact
Plots.default( size = (800, 800) )

module_lbl = "Available Modules: ";
available_modules = Observable( pkgchildren2( Main ) )
module_txt = Widgets.dropdown( available_modules[] );
module_btn = Widgets.button( "Inspect" );
throttle(0.05, module_btn)

types_to_functions = Widgets.toggle(true; label = "Types 🡆 Functions");
functions_to_functions = Widgets.toggle(true; label = "Functions 🡆 Functions");
views = vbox( types_to_functions, functions_to_functions );
topload = hbox( pad(1em, module_lbl), pad(1em, module_txt), views, pad(1em, module_btn) );

graphdisplay = Observable{Any}( "Please Inspect a Module..." );

mainwindow = vbox(  topload, graphdisplay );

sherlock = Observable( Detective( Sherlock ) )

function make_graph( d::Detective, selected_module::Symbol,
                    types_to_fns, fns_to_fns )
    if types_to_fns || fns_to_fns
        d = Detective( getfield(Main, selected_module) )
        types_to_fns    && typetype_edges(d)
        fns_to_fns      && functiontype_edges(d)
        focus_lbl       = "Focus On: "
        focus_btn       = Widgets.button( "Focus" );
        focus_txt       = Widgets.dropdown( vcat(types(d), functions(d)) );
        focus_frame     = vbox( hbox( pad(1em, focus_lbl), pad(1em, focus_txt), pad(1em, focus_btn) ) );
        throttle(0.05, focus_btn)
        map!( x -> magnify( sherlock[], Symbol(focus_txt[]) ), graphdisplay, focus_btn)
        return vbox( Interact.hline(), focus_frame, sherlockplot(d))
    else
        return "Please Choose a Module or a View..."
    end
end

map!( x -> make_graph(  sherlock[], module_txt[], types_to_functions[],
                        functions_to_functions[] ),
                    graphdisplay, module_btn)

w = Window( async = true )
body!( w, mainwindow, async = true )
