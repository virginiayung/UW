clear all; close all;

A=[6 2 1; 2 3 1; 1 1 1]
V=[0;1;0]

norm(V)

lamda=transpose(V)*A*V
r= A*V -lamda*V
i = 1
nr(i) = norm(r)

mu =2

while (norm(r) > 10^(-6))
    V
    w = (A-mu*eye(3))\V
    V = w/norm(w)
    lamda = transpose(V)*A*V
    r= (A*V)-(lamda*V)
    i= i+1
    nr(i) = norm(r) 
    
end

nr =nr(1:5)
nr=nr.'

V=-1*V


save eigenvalue.dat lamda -ascii
save eigenvector.dat V -ascii

save normresidual.dat nr -ascii








