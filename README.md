# Sherlock

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://caseykneale.github.io/Sherlock.jl/stable)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://caseykneale.github.io/Sherlock.jl/dev)
[![Build Status](https://travis-ci.com/caseykneale/Sherlock.jl.svg?branch=master)](https://travis-ci.com/caseykneale/Sherlock.jl)
[![Codecov](https://codecov.io/gh/caseykneale/Sherlock.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/caseykneale/Sherlock.jl)
[![Build Status](https://api.cirrus-ci.com/github/caseykneale/Sherlock.jl.svg)](https://cirrus-ci.com/github/caseykneale/Sherlock.jl)

### Overview
The goal for Sherlock is to make it easy to create design document charts, and interrogate packages from a "high level" either visually or programmatically (from the REPL, or whatever). The current state of the code is somewhere between "hot mess" and "early sunday morning hacking away". So, feel free to contribute, or clean things up, or whatever you want.

This was started because someone wanted some design document things from another project. So, rather then go through that drudgery it seemed most appropriate to make a tool that let's people do this for everyone - easily.

Right now there's only a little functionality to this package. You can use either a WebUI or the command line

```Julia
using Sherlock
sherlock_UI()
```
![image](https://raw.githubusercontent.com/caseykneale/Sherlock.jl/master/images/webui.png)


```Julia
using LightGraphs, GraphRecipes, Plots
using Sherlock

d = Detective( Sherlock )
typetype_edges(d)
functiontype_edges(d)

functions(d)
types(d)

abstracttypes(d)
undefined(d)

sherlockplot(d)

magnify( d, :Detective )
```

That's about really all there is too this for now. Please file bug reports, make PR's and suggestions.
