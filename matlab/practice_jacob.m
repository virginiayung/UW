% Iterative Solutions of linear euations:(1) Jacobi Method
% Linear system: A x = b
% Coefficient matrix A, right-hand side vector b
A=[4 -1 -1 0; -1 4 0 -1; -1 0 4 -1; 0 -1 -1 4]
b= [0; 0; 1; 1];
[m,n]=size(A)
% Set initial value of x to zero column vector 
x0=zeros(n,1);
% Set Maximum iteration number k_max
k_max=400;
% Set the convergence control parameter tol
tao = 10^(-8)
% Show the matrix with diag enties of A
D=diag(diag(A))
B= A-D
% loop for iterations
for k=1:k_max
    for i=1:n
        s=0;
        for j=1:n    
            s=s+B(i,j)*x0(j);
        end
        x1(i)=(b(i)-s)/A(i,i);
    end
    x0 = x1.'
    if norm(b-A*x0)<= tao*norm(b)
      break 
    end
end
% show the final solution
x_jacobi = x0
% show the total iteration number
iter_jacobi=k