import QPDAS
@doc
"""
berechnet M und wendet den Löser QuadraticProgram auf M an und gibt die Alphas zurueck
"""
function quadratic_program(X::AbstractArray)

  k = size(X)[1]
  y = X[:,3]
  x = X[:,1:2]
  M = zeros(Int64,k,k)
  for i in 1:k
    for j in 1:k
      M[i,j] = transpose(x[i,:]) * x[j,:]
      M[i,j] *= y[i]*y[j]
    end
  end

  #passt die einzugebenden Parameter an, um unsere gewuenschte Bedingungen zu realisieren
  A = transpose(y)
  b = vec(zeros(Int64,k,1))
  C = -ones(Int64,1,k) #LET MEEE INNNN!!! (QP will mein C nicht nehmen ;_;)
  d = vec(zeros(Int64,k,1))
  z = vec(ones(Int64, k,1))
  P = M

  qp = QPDAS.QuadraticProgram(A, b, C, d, z, P; semidefinite=true, ϵ = sqrt(eps()), smartstart=true)

  #sol, val = solve!(qp)
end

#X = [1 1 1 ; 2 2 1 ; 2 1 -1 ; 3 2 -1]
