using Pkg
Pkg.add("QPDAS")
Pkg.add("PyCall")
Pkg.add("Conda")

include("quadratic_program.jl")
include("daten_einlesen.jl")
include("berechnungen.jl")

dir = @__DIR__
dir *= "/"
filename = "Beispiel_2.txt"
params_filename = "params_" * filename
X = read_points(dir*filename)
α = quadratic_program(X)
w, b = calculate_params(α, X)
save_params_to_file(w, b, params_filename)

# # Call to Python
# ENV["PYTHON"] = ""
# Pkg.build("PyCall")
# using PyCall
# using Conda
# Conda.add("numpy")
# Conda.add("matplotlib")
# pybin = Conda.PYTHONDIR
# # run(`source $dir.venv/bin/activate`)
# run(`$pybin visualize.py $filename`)
