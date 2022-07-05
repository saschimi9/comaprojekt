using DelimitedFiles

@doc """
Berechnet die Parameter w und b und gibt diese zurueck.
"""
function calculate_params(alpha::Vector, l::Matrix)
    if size(alpha)[1]!=size(l)[1]
        throw(error("falsche Dimension"))
    else
        X=l[:,1:2] 
        Y=l[:,3]
        k=size(Y)[1]
        w = alpha[1]*Y[1]*X[1:1,:]
        
        for i=2:k[1]
            w += alpha[i]*Y[i]*X[i:i,:]
        end

        A=[alpha l]   
        s = size(A)[1]
        counter=0     #Zeilendimension der Teilmatrix mit alpha >10^-5.
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

@doc """
Speichert die Parameter w und b als .txt Datei.
"""
function save_params_to_file(w, b, filename::String)
    param =[w, b]
    writedlm(filename, param)
end
