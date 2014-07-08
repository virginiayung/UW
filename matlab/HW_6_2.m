clear all; close all;

A=[2 3 2;10 3 4;3 6 1]

V=[0;0;1]

lamda= transpose(V)*A*V
r= A*V -lamda*V

i =1
nr(i)=norm(r)
while (norm(r) > 10^(-6))
    V
    w = A *V
    V = w/norm(w)
    lamda = transpose(V)*A*V
    r= (A*V)-(lamda*V)
    i= i+1
    nr(i) = norm(r) 
    
end

nr =nr(1:5)

save eigenvalue.dat lamda -ascii
save eigenvector.dat V -ascii

save normresidual.dat nr -ascii


  