using LinearAlgebra
using DelimitedFiles

@doc """
Berechnet die Parameter w und b und gibt diese zurueck.
"""
function calculate_params(alpha, l)
    X=l[:,1:2]  #teilmatrix der Spalten 1-2
    Y=l[:,3]
    k=length(Y)
    w = alpha[1]*Y[1]*X[1:1,:]
    #X[i:i,:] Zeilenvektor in Zeile i
    for i=2:k
        prod1 = alpha[i]*Y[i]*X[i:i,:]
        w = w+prod1
    end
    println(w)

    #Summe richtig mit der Indexierung? Und: Datentypen festlegen?
    b=0
    summe =[0 0]
    for i=1:k
        if alpha[i]>10^-5
            prod2=alpha[i]*Y[i]*X[i:i,:]
            summe=summe+prod2
        end
    end
    for i=1:k
        if alpha[i]>10^-5
            differenz=Y[i]- dot(summe,X[i:i,:])
            b=b+differenz
        end
    end
    b=b/2
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

#a = [1; 2; 1; 4]
#A = [1 2 1; 1 2 -1; 1 2 -1; 1 2 1]
#calculate_params(a,A)

#save_params_to_file([2 4], -20, "/Users/Hannah/Desktop/Coma_Python_Ha/Coma_II/Beispiel.txt")
