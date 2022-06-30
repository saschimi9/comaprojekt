include("../berechnungen.jl")
using Test

@test calculate_params([1], [0 1 1]) == [0 1], 0

# @test calculate_params([1, 1], [0 1 1, 1 1 -1])