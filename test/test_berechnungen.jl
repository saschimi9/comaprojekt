include("../berechnungen.jl")
using Test

@test calculate_params([1], [0 1 1])== ([0, 1], 0)
@test calculate_params([1; 1], [1 0 1; 0 1 -1])== ([1, -1], 0)
@test calculate_params([-1; 1], [1 0 1; 0 1 -1]) == ([-1, -1], 0)
@test calculate_params([1; 1; 2], [0 0 1; 0 1 1; 1 0.5 -1]) == ([-2, 0], 1)
@test calculate_params([1; 0; 1], [0 0 1; 0 1 1; 1 -1 -1]) ==([-1, 1], 1)
#@test calculate_params([1], [0 1 1; 0 1 1])== DomainError

#Testfälle:
#1) Randfall mit keiner Eingabe -> soll Fehlermeldung werfen
#2) Fall mit falschem Format -> soll Fehlermeldung werfen (Julia-fkt die Dimension der Datentypen zusammenpasst)
#2) Fälle mit einem, zwei und drei Punkten und dann von Hand ausrechnen!
