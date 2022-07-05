using Pkg
Pkg.add("QPDAS")

include("quadratic_program.jl")
include("daten_einlesen.jl")
include("berechnungen.jl")

dir = @__DIR__
filename = ARGS[1]
params_filename = "params_" * filename
X = read_points(dir*"/"*filename)
α = quadratic_program(X)
w, b = calculate_params(α, X)
save_params_to_file(w, b, params_filename)

# Call to Python
run(`$dir/venv/bin/python visualize.py $filename`)
