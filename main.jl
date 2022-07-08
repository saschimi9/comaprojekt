using Pkg
Pkg.add("QPDAS")

include("quadratic_program.jl")
include("daten_einlesen.jl")
include("berechnungen.jl")

dir = @__DIR__
filename = ARGS[1]
params_filename = "params_" * filename
X = read_points(dir*"/"*filename)
try
  α = quadratic_program(X)
  w, b = calculate_params(α, X)
  save_params_to_file(w, b, params_filename)
catch LoadError
  println("Did not converge!")
  w, b = calculate_params([1], [1 1 1]) # just some example values
  save_params_to_file(w, b, params_filename)
end
# Call to Python
if Sys.iswindows()
  run(`python visualize.py $filename`)
else
  run(`$dir/venv/bin/python visualize.py $filename`)
end
