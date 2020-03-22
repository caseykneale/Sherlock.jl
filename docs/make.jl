using Documenter, Sherlock

makedocs(;
    modules=[Sherlock],
    format=Documenter.HTML(),
    pages=[
        "Home" => "index.md",
    ],
    repo="https://github.com/caseykneale/Sherlock.jl/blob/{commit}{path}#L{line}",
    sitename="Sherlock.jl",
    authors="Casey Kneale",
    assets=String[],
)

deploydocs(;
    repo="github.com/caseykneale/Sherlock.jl",
)
