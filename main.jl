using Pkg
Pkg.add("QPDAS")

include("quadratic_program.jl")
include("daten_einlesen.jl")
include("berechnungen.jl")

dir = @__DIR__
dir *= "/"
filename = "Beispiel_1.txt"
params_filename = "params_" * filename
X = read_points(dir*filename)
α = quadratic_program(X)
w, b = calculate_params(α, X)
save_params_to_file(w, b, params_filename)

# Call to Python
if Sys.iswindows()
  run(`python visualize.py $filename`)
else
  run(`$dir.venv/bin/python visualize.py $filename`)
end
