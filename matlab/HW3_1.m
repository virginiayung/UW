clear all; close all;
%TEST A=[0 2 0; 2 1 4; 0 4 5];
A= [2, -1, 0; 1, 6, -2; 4, -3, 8];

[ma,na]=size (A)


for j = 1: na
    va(:,j) = A(:,j)
    for i = 1 : j-1
        ra(i,j) = (qa(:,i)')* A(:,j)
        va(:,j) = va(:,j) - ra(i, j)* qa(:,i)
    end
    ra(j, j) = norm(va(:,j))
    qa(:,j) = va(:,j) / ra(j, j)
end

save qa.dat qa -ascii

save ra.dat ra -ascii


B=load('MatrixB.dat');

[mb, nb]=size(B)


for j = 1: nb
    vb(:,j) = B(:,j)
    for i = 1 : j-1
        rb(i,j) = (qb(:,i)')* B(:,j)
        vb(:,j) = vb(:,j) - rb(i, j)* qb(:,i)
    end
    rb(j, j) = norm(vb(:,j))
    qb(:,j) = vb(:,j) / rb(j, j)
end

save qb.dat qb -ascii

save rb.dat rb -ascii


  
        
