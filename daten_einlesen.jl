using DelimitedFiles

@doc """
Liest Textdatei ein und gibt Matrix mit Floateintraegen zurueck.
"""
function read_points(filename::String)
    data=readdlm(filename)
    return data
end


