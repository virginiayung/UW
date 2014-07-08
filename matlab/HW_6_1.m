clear all; close all;

A=load('MatrixB.dat')

[mb, nb]=size(A)

for k = 1: mb-2
    x = A(k+1:mb, k)
    e=eye(mb-k, nb-k)
    v(k+1:mb,k) = [sign(x(1))*norm(x)*e(:,1)]+x
    v(k+1:mb,k) = v(k+1:mb,k)/norm(v(k+1:mb,k))
    
    
    A(k+1:mb,k:mb) = A(k+1:mb,k:mb)-2*v(k+1:mb,k)*[v(k+1:mb,k)'*A(k+1:mb,k:mb)]
    A(1:mb,k+1:mb) = A(1:mb,k+1:mb)-2*[A(1:mb,k+1:mb)*v(k+1:mb,k)]*v(k+1:mb,k)'
end

v1= v(2:mb,1)
v2= v(3:mb,2)


save v1.dat v1 -ascii
save v2.dat v2 -ascii
save h.dat A -ascii

norm(v1)
norm(v2)
