using LinearAlgebra
using QPDAS

@doc """
Berechnet M und wendet den Löser QuadraticProgram auf M an und gibt die Alphas zurueck
"""

function quadratic_program(X::Matrix)
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
  #Ohne die sehr "kleine" draufaddierte Einheitsmatrix denkt QPDAS, dass M nicht pos definit ist (warum auch immer)
  E = 0.001
  M += E*Matrix{T}(I,k,k)
  #passt die einzugebenden Parameter an, um unsere gewuenschte Bedingungen zu realisieren
  A = zeros(k,k)
  for i in 1:k
    A[i,:] = y
  end
  b = vec(zeros(T,k,1))
  C = -Matrix{T}(I,k,k)
  d = vec(zeros(T,k,1))
  z = vec(ones(T,k,1))
  P = M
  qp = QPDAS.QuadraticProgram(A,b,C,d,z,P)

  sol,val = solve!(qp)
  println(sol,val)
end

X = [2.0 1.0 -1
4.0 1.0 -1
4.0 3.0 -1
1.0 2.0 1
1.0 4.0 1
3.0 4.0 1]
quadratic_program(X)
