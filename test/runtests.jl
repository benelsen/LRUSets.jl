
using Test
using LRUSets

@testset "LRUSets.jl" begin

    s = LRUSet(3)

    @test s isa LRUSet{Any}
    @test s.max_size === 3

    @test length(s) === 0
    @test issetequal(values(s), [])

    push!(s, "foo")
    @test length(s) === 1
    @test issetequal(values(s), ["foo"])

    push!(s, "foo")
    @test length(s) === 1
    @test issetequal(values(s), ["foo"])

    push!(s, "bar")
    push!(s, "baz")
    push!(s, "faz")
    @test length(s) === 3
    @test issetequal(values(s), ["bar", "baz", "faz"])

    s = LRUSet(
        3,
        Dict(
            42 => UInt64(2),
            10 => UInt64(3),
        ),
    )

    @test s isa LRUSet{Int}
    push!(s, 1)
    @test issetequal(values(s), [1, 42, 10])

    s = LRUSet{Integer}(2)
    @test s isa LRUSet{Integer}

    push!(s, Int16(21))
    push!(s, Int128(42))
    push!(s, UInt64(84))
    push!(s, UInt8(255))
    @test issetequal(values(s), [UInt64(84), UInt8(255)])

    @test issetequal([s...], [UInt64(84), UInt8(255)])

end
