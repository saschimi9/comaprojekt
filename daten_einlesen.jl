using DelimitedFiles

@doc """
Liest Textdatei ein und gibt Matrix mit Floateintraegen zurueck.
"""
function read_points(filename::String)

    data=readdlm(filename)
    return data
end

#data=readdlm("/Users/Hannah/Desktop/Coma_Python_Ha/Coma_II/Beispiel.txt")
