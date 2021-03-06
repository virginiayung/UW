close all; clear all;
% bvp_2.m 
% second order finite difference method for the bvp
%   u''(x) = f(x),   u'(ax)=sigma,   u(bx)=beta
% Using 3-pt differences on an arbitrary nonuniform grid.
% Should be 2nd order accurate if grid points vary smoothly, but may
% degenerate to "first order" on random or nonsmooth grids. 
%
% Different BCs can be specified by changing the first and/or last rows of 
% A and F.
%
% From  http://www.amath.washington.edu/~rjl/fdmbook/  (2007)

ax = 0;
bx = 1;
alpha = 2;   % Dirichlet boundary condition at ax
beta = 3;     % Dirichlet boundary condtion at bx



f = @(x) 0*x;  % right hand side function
utrue = @(x)(2*cos(x)+(3-2*cos(bx))/sin(bx)*sin(x));  % true soln

% true solution on fine grid for plotting:
xfine = linspace(ax,bx,101);
ufine = utrue(xfine);

% hval=1/8;
% m1=(bx-ax)/hval;
% m2 = m1 + 1;
% m = m1 - 1;                 % number of interior grid points


m1vals = [8];
%m1vals = [5 10 20 40 80 160 320];
ntest = length(m1vals);
hvals = zeros(ntest,1);  % to hold h values
E = zeros(ntest,1);      % to hold errors

for jtest=1:ntest
  m1 = m1vals(jtest);
  m2 = m1 + 1;
  m = m1 - 1;                 % number of interior grid points
  hvals(jtest) = (bx-ax)/m1;
  % set grid points:  
  gridchoice = 'random';          % see xgrid.m for other choices
  x = xgrid(ax,bx,m,gridchoice); 
  I = eye(m2);
  F = zeros(m2,1);

  % set up matrix A (using sparse matrix storage):
  A = spalloc(m2,m2,3*m2);   % initialize to zero matrix

  % first row for Dirichlet BC at ax:
  A(1,1:2) =  [-2/hvals(jtest).^2,1/hvals(jtest).^2];

  % interior rows:
  for i=2:m1
     A(i,i-1:i+1) = fdcoeffF(2, x(i), x((i-1):(i+1)));
     end

  % last row for Dirichlet BC at bx:
    A(m2,m1:m2) = [1/hvals(jtest).^2,-2/hvals(jtest).^2];
  
  % Right hand side:
    F =f(x);
    F(1) = -1/(hvals(jtest).^2)*alpha;
    F(m2)= -1/(hvals(jtest).^2)*beta; 
  
  % solve linear system:
    U = (A+I)\F;


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
  plot(xfine,ufine, '-m')  % plot true solution
  hold off
  S= full(A);
  hleg1 = legend('computedU','exactU');
  min(abs(eig(S+I)))
  1/(min(abs(eig(S+I))))
  
  % pause to see this plot:  
  drawnow
  input('Hit <return> to continue ');
  
end
error_table(hvals, E);   % print tables of errors and ratios
error_loglog(hvals, E);  % produce log-log plot of errors and least squares fit

