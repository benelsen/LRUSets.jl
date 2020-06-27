using LRUSets
using Documenter

makedocs(;
    modules=[LRUSets],
    authors="Ben Elsen <mail@benelsen.com",
    repo="https://github.com/benelsen/LRUSets.jl/blob/{commit}{path}#L{line}",
    sitename="LRUSets.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://benelsen.github.io/LRUSets.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/benelsen/LRUSets.jl",
)
