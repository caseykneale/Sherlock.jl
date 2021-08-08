using Documenter, Sherlock

makedocs(;
    format = Documenter.HTML(
        prettyurls = get(ENV, "CI", nothing) == "true"
    ),
    pages=[
        "Home" => "index.md",
    ],
    repo="https://github.com/caseykneale/Sherlock.jl/blob/{commit}{path}#L{line}",
    sitename="Sherlock.jl",
    authors="Casey Kneale",
    assets=String[],
)

deploydocs(;
    repo="github.com/caseykneale/Sherlock.jl.git",
    devbranch = "master",
)
