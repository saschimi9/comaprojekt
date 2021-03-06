using LinearAlgebra
using QPDAS

@doc """
Berechnet M und wendet den Löser QuadraticProgram auf M an und gibt die Alphas zurueck
"""
function quadratic_program(X::Matrix)
  if size(X)[2] != 3
    throw(error("falsche Anzahl an Spalten in Matrix"))
  else
    for i in 1:size(X)[1]
      if !(X[i,3] in [1 -1])
        throw(error("in den Eintraege von Spalte 3 steht was anderes als -1 oder 1"))
      end
    end
    T = Float64
    k = size(X)[1]
    y = X[:,3]
    x = X[:,1:2]
    M = zeros(T,k,k)
    for i in 1:k
      for j in 1:k
        M[i,j] = transpose(x[i,:]) * x[j,:]
        M[i,j] *= y[i]*y[j]
      end
    end

    # Regularisieren
    E = 0.000001
    M += E*Matrix{T}(I,k,k)

    # Passt die einzugebenden Parameter an, um unsere gewuenschte Bedingungen zu realisieren
    A = zeros(1,k)
      for i in 1:k
        A[i] = y[i]
      end
    b = vec(zeros(1,1))
    C = -Matrix{T}(I,k,k)
    d = vec(zeros(T,k,1))
    z = vec(-ones(T,k,1))
    P = M

    # Loeser aufrufen
    qp = QPDAS.QuadraticProgram(A,b,C,d,z,P)
    sol,val = solve!(qp)

    return sol
  end
end
