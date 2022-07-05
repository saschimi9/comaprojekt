include("../berechnungen.jl")
using Test

#Testfaelle
@test calculate_params([1], [0 1 1])== ([0 1], 0)
@test calculate_params([1; 1], [1 0 1; 0 1 -1])== ([1 -1], 0)
@test calculate_params([-1; 1], [1 0 1; 0 1 -1]) ==([-1 -1],0)
@test calculate_params([1; 1; 2], [0 0 1; 0 1 1; 1 0.5 -1])== ([-2 0], 1)
@test calculate_params([1; 0; 1], [0 0 1; 0 1 1; 1 -1 -1])==([-1 1], 1)

#Test fuer ungueltige Dimension
@test_throws ErrorException calculate_params([1], [0 1 1; 0 1 1])
