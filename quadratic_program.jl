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

  #passt die einzugebenden Parameter an,um unsere gewuenschte Bedingungen zu realisieren
  A = zeros(k,k)
  for i in 1:k
    A[i,:] = y
  end
  b = vec(zeros(k,1))
  C = -Matrix{T}(I,k,k) #LET MEEE INNNN!!! (QP will mein C nicht nehmen ;_;)
  C = ones(T,k,k)
  d = vec(zeros(T,k,1))
  z = vec(ones(T,k,1))
  P = M

  qp = QPDAS.QuadraticProgram(A,b,C,d,z)

  sol,val = solve!(qp)
  println(sol,val)
end

# k = 4
# T = Float64
# X = [1. 1. 1 ; 2. 2. 1 ; 2. 1. -1 ; 3. 2. -1]
# y = X[:,3]'
# A = zeros(k,k)
# for i in 1:k
#   A[i,:] = y
# end
# b = vec(zeros(k,1))
# C = -Matrix{T}(I,k,k)
# d = vec(zeros(k,1))
# z = vec(ones(T,k,1))
# P = Matrix{T}(I,k,k)

# qp = QPDAS.QuadraticProgram(A,b,C,d,z,P)
# sol,val = solve!(qp)
# println(sol,val)

X = [1. 1. 1 ; 2. 2. 1 ; 2. 1. -1 ; 3. 2. -1]
quadratic_program(X)