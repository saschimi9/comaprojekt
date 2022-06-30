include("../quadratic_program.jl")
using Test

X = [2.0 1.0 -1
4.0 1.0 -1
4.0 3.0 -1
1.0 2.0 1
1.0 4.0 1
3.0 4.0 1]

Y = [3.0 1.0 1
1.0 3.0 1
4.0 4.0 -1
6.0 4.0 -1
4.0 6.0 -1]

@test quadratic_program(X)
@test quadratic_program(Y)
