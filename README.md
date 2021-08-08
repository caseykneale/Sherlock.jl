# Sherlock

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://caseykneale.github.io/Sherlock.jl/stable)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://caseykneale.github.io/Sherlock.jl/dev)
[![Build Status](https://github.com/caseykneale/Sherlock.jl/workflows/CI/badge.svg)](https://github.com/caseykneale/Sherlock.jl/actions)
[![codecov](https://codecov.io/gh/caseykneale/Sherlock.jl/branch/master/graph/badge.svg?token=ZPRP2ry4rY)](https://codecov.io/gh/caseykneale/Sherlock.jl)

## Overview
The goal for Sherlock is to make it easy to create design document charts, and interrogate packages from a "high level" either visually or programmaticly (from the REPL, or whatever). This was started because someone wanted some design document things from another project. So, rather then go through that drudgery it seemed most appropriate to make a tool that let's people do this for everyone - easily.

### Whats displayed?
 - Types, Abstract Types, Functions, Dynamically Typed items, and Undefined exports are all displayed.
 - First order connections between these items are all visible and stored in a Graph structure backend.
 - Second or higher order connectivity is not currently guaranteed. (IE: the relationship between `ConcreteType` and `AbstractType2` in the following example: `ConcreteType <: AbstractType1{AbstractType2}`, will not be displayed except maybe in the `TypeTree` plot ).
 - Macros are also not displayed because these puppies dynamically generate code, that's just out of the scope of this project for now.
 - Types which do not belong directly to an inspected Module are also not displayed. Think of how confusing that could be?


There are 2 options for displaying the visualizations herein: the WebUI or the command line.

### WebUI
```Julia
using Sherlock
sherlock_UI()
```
![image](https://raw.githubusercontent.com/caseykneale/Sherlock.jl/master/images/webui.png)

### CLI/REPL
```Julia
using LightGraphs, GraphRecipes, Plots
using Sherlock

d = Detective( Sherlock )
#what's connected to what
typetype_edges(d)
functiontype_edges(d)
#what types are in this module?
functions(d)
types(d)
abstracttypes(d)
undefined(d)
#plot a normal sherlock overview plot
sherlockplot(d)
#Zoom in on a specifc item in the detective instance
magnify( d, :Detective )
```

The current state of the code is somewhere between "hot mess" and "early Sunday morning hacking away". If anyone would like to contribute to making this package either more robust, more information rich, or more clean I'd really appreciate it!
