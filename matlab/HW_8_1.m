clear all; close all;

randn('state',1);
m=200;
A = 2*eye(m) + 0.5*randn(m)/sqrt(m);
[M,n]=size(A)
k_max = 400
b=ones(m,1)

tao= 10^(-8)

D = diag(diag(A))
B = A - D
x0=zeros(n,1)

for k = 1: k_max  
    for i = 1:n
        s=0;
        for j= 1:n
            s = s+ B(i,j)*x0(j)
        end
        u(i)= (b(i)-s)/A(i,i)
    end
    x0 = u.'
    if norm(b-A*x0) <= tao*norm(b)
        break
    end
end
   
x_jacobi = x0
iter_jacobi = k

save x_jacobi.dat x_jacobi -ascii
save iter_jacobi.dat iter_jacobi -ascii


% Gauss_Sedel

x= zeros(n,1)
for k = 1: k_max  
    for i = 1:n
        s=0;
        for j= 1:n
            s = s+ B(i,j)*x(j)
        end
        x(i)= (b(i)-s)/A(i,i)
    end
    if norm(b-A*x) <= tao*norm(b)
        break
    end
end

x_gauss = x
iter_gauss =k
save x_gauss.dat x_gauss -ascii
save iter_gauss.dat iter_gauss -ascii

[x_jacobi, x_gauss]

