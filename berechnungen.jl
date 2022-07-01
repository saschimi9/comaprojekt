using DelimitedFiles

@doc """
Berechnet die Parameter w und b und gibt diese zurueck.
"""
function calculate_params(alpha::VT, l::MT) where {T, VT<:AbstractVector{T}, MT<:AbstractMatrix{T}}
    X=l[:,1:2]  #teilmatrix der Spalten 1-2
    Y=l[:,3]
    k=length(Y)
    w = alpha[1]*Y[1]*X[1:1,:]
    #X[i:i,:] Zeilenvektor in Zeile i
    for i=2:k
        prod1 = alpha[i]*Y[i]*X[i:i,:]
        w = w+prod1
    end

    A=[alpha l]     #schreibe Liste und alpha in selbe Matrix
    A=[A[:,1] .>10^(-5), :]      #filtert nur alpha Werte >0 in erster Spalte.
    l = length(A)
    b=0
    for i=1:l
        c=0
        for j =1:l
            c+=A[1,j]*A[4,j]*A[2:3,j]'*A[2:3,i]
        b+=Y[i]-c
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
