clear all; close all;

B=load('MatrixB.dat')
eps=10^(-4)


[mb, nb]=size(B)
 
e=eig(B)

D=diag(diag(B))
A =B - diag(diag(B))
abs(A)
max(max(abs(A)))
max(max(diag(diag(B))))


i=0

while max(max(abs(A))) > eps* max(max(abs(D)))
    
    [q,r]=qr(B,0)
    B= r*q
    i=i+1
    A=B - diag(diag(B))
    max(max(abs(A)))
    D=diag(diag(B))
    max(max(abs(D)))
    
end
diagb=diag(B)
iterb=i


save diagb.dat diagb -ascii


save iterb.dat iterb -ascii
