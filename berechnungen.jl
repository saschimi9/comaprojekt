using DelimitedFiles

@doc """
Berechnet die Parameter w und b und gibt diese zurueck.
"""
function calculate_params(alpha::Vector, l::Matrix)
    if size(alpha)[1]!=size(l)[1]
        throw(DomainError(alpha, "falsche Dimension"))
    else
        X=l[:,1:2]  #Teilmatrix der Spalten 1-2
        Y=l[:,3]
        k=size(Y)[1]
        w = alpha[1]*Y[1]*X[1:1,:]
        #X[i:i,:] Zeilenvektor in Zeile i
        for i=2:k[1]
            prod1 = alpha[i]*Y[i]*X[i:i,:]
            w = w+prod1
        end

        A=[alpha l]     #schreibe Liste und alpha in selbe Matrix
        s = size(A)[1]
        counter=0       #Zähler für richtige size
        b=0
        for i=1:s
            c=0
            if A[i,1]>10^-5
                for j =1:s
                    if A[j,1]>10^-5
                        c+=A[j,1]*A[j,4]*A[j,2:3]'*A[i,2:3]
                    end
                end
                b+=Y[i]-c
                counter+=1
            end
        end
        b=b/counter
        return w, b
    end
end
#- filename =problem_{i}_param.txt`
@doc """
Speichert die Parameter w und b als .txt Datei.
"""
function save_params_to_file(w, b, filename::String)
    param =[w, b]
    writedlm(filename, param)
end

#save_params_to_file([2 4], -20, "/Users/Hannah/Desktop/Coma_Python_Ha/Coma_II/Beispiel.txt")
