include("../quadratic_program.jl")
using Test

#die zwei Beispiele aus der Aufgabenstellung
bsp1 = [2.0 1.0 -1
4.0 1.0 -1
4.0 3.0 -1
1.0 2.0 1
1.0 4.0 1
3.0 4.0 1]

bsp2 = [3.0 1.0 1
1.0 3.0 1
4.0 4.0 -1
6.0 4.0 -1
4.0 6.0 -1]

#zwei weitere Beispiele
horiz_line = [1 1 1
1 0 -1]

verti_line = [1 1 1
0 1 -1]

#jedes Beispiel getestet mit Fehler <10^-4
@test isapprox(quadratic_program(bsp1), [0.5, 0.0, 0.5, 0.5, 0.0, 0.5]; atol = 10^-4)
@test isapprox(quadratic_program(bsp2), [0.125, 0.125, 0.25, 0.0, 0.0]; atol = 10^-4)
@test isapprox(quadratic_program(horiz_line), [2.0, 2.0]; atol = 10^-4)
@test isapprox(quadratic_program(verti_line), [2.0, 2.0]; atol = 10^-4)

#include("quadratic_program.jl")
#include("berechnungen.jl")
