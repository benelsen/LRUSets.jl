
module LRUSets

import Base: push!, length, values, eltype, iterate

export LRUSet

struct LRUSet{K}
    max_size::Int
    map::Dict{K, UInt64}
    last::Threads.Atomic{UInt64}

    function LRUSet{K}(max_size::Int, map::Dict{K, UInt64}) where {K}
        last = length(map) > 0 ? maximum(values(map)) : UInt64(0)
        new(max_size, map, Threads.Atomic{UInt64}(last))
    end
end

function LRUSet{K}(max_size::Int) where {K}
    LRUSet{K}(
        max_size,
        Dict{K, UInt64}(),
    )
end

function LRUSet(max_size::Int, map::Dict{K, UInt64}) where {K}
    LRUSet{K}(
        max_size,
        map,
    )
end

LRUSet(max_size::Int) = LRUSet{Any}(max_size)

length(ts::LRUSet) = length(ts.map)
eltype(::Type{LRUSet{K}}) where {K} = K

values(ts::LRUSet) = keys(ts.map)

iterate(ts::LRUSet, state = 1) = iterate(keys(ts.map), state)

function push!(ts::LRUSet{K}, e::K) where {K}
    ts.map[e] = Threads.atomic_add!(ts.last, UInt64(1))
    if length(ts) > ts.max_size
        v, k = findmin(ts.map)
        delete!(ts.map, k)
    end
    nothing
end

end
