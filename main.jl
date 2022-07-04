using Pkg
Pkg.add("QPDAS")

include("quadratic_program.jl")
include("daten_einlesen.jl")
include("berechnungen.jl")

filename = "Beispiel_1.rtf"
params_filename = "params" * filename
X = read_points(filename)
α = quadratic_program(X)
# w, b = calculate_params(α, X)
# save_params_to_file(params_filename)
