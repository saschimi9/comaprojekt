using DelimitedFiles

@doc """
Berechnet die Parameter w und b und gibt diese zurueck.
"""
function calculate_params(α::VT, X::MT) where {T, VT<:AbstractVector{T}, MT<:AbstractMatrix{T}}
    x=X[:,1:2]  #teilmatrix der Spalten 1-2
    y=X[:,3]
    k=size(y)[1]
    w = α[1]*y[1]*x[1,:]
    #X[i:i,:] Zeilenvektor in Zeile i
    for i=2:k
        prod1 = α[i]*y[i]*x[i,:]
        w = w + prod1
    end

    A=[α X]     #schreibe Liste und alpha in selbe Matrix
    A=A[A[:,1] .>10^(-5), :]      #filtert nur alpha Werte >0 in erster Spalte.
    l = size(A)[1]
    b=0
    for i=1:l
        c=0
        for j =1:l
            c += A[j,1]*A[j,4]*A[j,2:3]'*A[i,2:3]
        end
        b+=y[i]-c
    end
    b=b/l
    return w, b
end

#Fragen: passt das Format der .txt Datei?
#- filename =problem_{i}_param.txt`
@doc """
Speichert die Parameter w und b als .txt Datei.
"""
function save_params_to_file(w, b, filename::String)
    param =[w, b]
    writedlm(filename, param)
end

#Schreibe Testfälle:
#1) Randfall mit keiner Eingabe -> soll Fehlermeldung werfen
#2) Fall mit falschem Format -> soll Fehlermeldung werfen (Julia-fkt die Dimension der Datentypen zusammenpasst)
#2) Fälle mit einem, zwei und drei Punkten und dann von Hand ausrechnen!



#a = [1; 2; 1; 4]
#A = [1 2 1; 1 2 -1; 1 2 -1; 1 2 1]

#calculate_params(a,A)

#save_params_to_file([2 4], -20, "/Users/Hannah/Desktop/Coma_Python_Ha/Coma_II/Beispiel.txt")
