
% Solve 1d BVP obtained by discretizing u''(x) = f(x) 
% with Dirichlet boundary condtions  u(0) = alpha, u(1) = beta
% Discretized using centered difference.
%
% Compare matrix splitting methods:  Jacobi, Gauss-Seidel, and SOR
%
% From  http://www.amath.washington.edu/~rjl/fdmbook/  (2007)
clear all; close all;


% method = 'GS';  % 'Jacobi' or 'GS' or 'SOR'
method = 'backward__GS';  % backward GS

nplot = 10;          % iterate u is plotted every nplot iterations
maxiter = 100        % number of iterations to take

m = 39;
ax = 0;
bx = 1;
alpha = 0;
beta = 0;
eps= 0.0005;
% eps=0
f = @(x) ones(size(x));   % f(x) = 1
a=1;

h = (bx-ax) / (m+1);
x = linspace(ax, bx, m+2)';

% determine exact solution to linear system by setting up
% system Au = f and solving with backslash:
e = ones(m+2,1);

A = (eps/h^2 * spdiags([e -2*e e], [-1 0 1], m+2, m+2)) + (a/h*spdiags([e -1*e], [-1 0], m+2, m+2));

A(1,1:2) = [1 0];
A(m+2,m+1:m+2) = [0 1];
rhs = f(x);
rhs(1) = alpha;
rhs(m+2) = beta;
ustar = A\rhs;


% Decompose A = DA - LA - UA:
DA = diag(diag(A));   % diagonal part of A
LA = DA - tril(A);    % strictly lower triangular part of A (negated)
UA = DA - triu(A);    % strictly upper triangular part of A (negated)

% set up iteration matrix:
switch method
   case 'Jacobi'
      M = DA;
      N = LA + UA;
   case 'GS'
      M = DA - LA;
      N = UA;
   case 'backward__GS'
      M = DA - UA;
      N = LA;
   case 'SOR'
      % use optimal omega for this problem:
      omega = 2 / (1 + sin(pi*h));
      %omega = 1.99;
      M = 1/omega * (DA - omega*LA);
      N = 1/omega * ((1-omega)*DA + omega*UA);
   end


u = zeros(size(x));   % initial guess for iteration

figure(1)
%clf
plot(x,ustar,'r')
hold on
plot(x,u,'b')

error = nan(maxiter+1,1);
error(1) = max(abs(u-ustar));


% Iteration:
% ----------


for iter=1:maxiter

   u = M \ (N*u + rhs);
      
   error(iter+1) = max(abs(u-ustar));
   if mod(iter,nplot)==0
      % plot u every nplot iterations
      plot(x,u,'b')
      title(sprintf('%s: Iteration %4i, error = %9.3e',...
             method,iter,error(iter+1)),'FontSize',15)
        
      drawnow
      pause(.1)
      end
end
   
legend('true','forward_GS','backward_GS')

% plot errors vs. iteration:
figure(2)
% semilogy(error,'b')
semilogy(error,'m')

%axis([0 maxiter min(error)/10 1])

axis([0 100 min(error)/10 1])
title('Errors','FontSize',15)
xlabel('iteration')
hold on

% compute spectral radius of iteration matrix G:
G = M\N;
rhoG = max(abs(eig(full(G))));
disp(sprintf('Spectral radius of G for %s is %5f',method,rhoG))

legend('forward_GS','backward_GS')

