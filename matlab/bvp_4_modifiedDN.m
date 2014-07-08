close all; clear all;
% bvp4.m 
% second order finite difference method for the bvp
%   u''(x) = f(x),   u'(ax)=sigma,   u(bx)=beta
% fourth order finite difference method for the bvp
%   u'' = f,   u'(ax)=sigma,   u(bx)=beta
% Using 5-pt differences on an arbitrary grid.
% Should be 4th order accurate if grid points vary smoothly.
%
% Different BCs can be specified by changing the first and/or last rows of 
% A and F.
%
% From  http://www.amath.washington.edu/~rjl/fdmbook/chapter2  (2007)

ax = 0;
bx = 3;
alpha = -5;   % Neumann boundary condition at ax
beta = 3;     % Dirichlet boundary condtion at bx

f = @(x) exp(x);  % right hand side function
% utrue = @(x) exp(x) + (alpha-exp(ax))*(x - bx) + beta - exp(bx);  % true soln

utrue = @(x) exp(x) + (alpha-exp(ax)) + (beta - exp(bx))*(x - ax);  % true soln

% true solution on fine grid for plotting:
xfine = linspace(ax,bx,101);
ufine = utrue(xfine);

% Solve the problem for ntest different grid sizes to test convergence:
m1vals = [10 20 40 80];
ntest = length(m1vals);
hvals = zeros(ntest,1);  % to hold h values
E = zeros(ntest,1);      % to hold errors

for jtest=1:ntest
  m1 = m1vals(jtest);
  m2 = m1 + 1;
  m = m1 - 1;                 % number of interior grid points
  hvals(jtest) = (bx-ax)/m1;  % average grid spacing, for convergence tests

  % set grid points:  
  gridchoice = 'uniform';
  x = xgrid(ax,bx,m,gridchoice);   

  % set up matrix A (using sparse matrix storage):
  A = spalloc(m2,m2,5*m2);   % initialize to zero matrix

  %%%%%%% first row for Neumann BC on u'(x(1))
  %%%%%%% A(1,1:5) = fdcoeffF(1, x(1), x(1:5));
  
  % first row for Dirichlet BC on u(x(1))
  A(1,1:5) = fdcoeffF(0, x(1), x(1:5));
  
  % second row for u''(x(2))
  A(2,1:6) = fdcoeffF(2, x(2), x(1:6));

  % interior rows:
  for i=3:m
     A(i,i-2:i+2) = fdcoeffF(2, x(i), x((i-2):(i+2)));
     end

  % next to last row for u''(x(m+1))
  A(m1,m-3:m2) = fdcoeffF(2,x(m1),x(m-3:m2));
  
  %%%%%%% last row for Dirichlet BC on u(x(m+2))
  %%%%%%% A(m2,m-2:m2) = fdcoeffF(0,x(m2),x(m-2:m2));
  
  % last row for Neumann BC on u'(x(m+2))
  A(m2,m-2:m2) = fdcoeffF(1,x(m2),x(m-2:m2));
  

  % Right hand side:
  F = f(x); 
  F(1) = alpha;  
  F(m2) = beta;
  
  % solve linear system:
  U = A\F;


  % compute error at grid points:
  uhat = utrue(x);
  err = U - uhat;
  E(jtest) = max(abs(err));  
  disp(' ')
  disp(sprintf('Error with %i points is %9.5e',m2,E(jtest)))

  clf
  plot(x,U,'o')  % plot computed solution
  title(sprintf('Computed solution with %i grid points',m2));
  hold on
  plot(xfine,ufine)  % plot true solution
  hold off
  
  % pause to see this plot:  
  drawnow
  input('Hit <return> for next plot ');
  
  end

error_table(hvals, E);   % print tables of errors and ratios
error_loglog(hvals, E);  % produce log-log plot of errors and least squares fit
