
% poisson_class.m  -- solve the Poisson problem u_{xx} + u_{yy} = f(x,y)
% on [a,b] x [a,b]. Solving this with multigrid, 2-cycle  
% 
% The 5-point Laplacian is used at interior grid points.
% This system of equations is also solved using backslash
% to get uD, the exact discrete solution to compare with the
% multigrid output in order to study the errors, say upre-uD
% after pre-relax, or ucgc-uD after coarse grid correction, etc.
% 
% From  http://www.amath.washington.edu/~rjl/fdmbook/chapter3  (2007)

clear all; close all;
a = 0; 
b = 1;


m1vals = [8 16 32];
ntest = length(m1vals);
hvals = zeros(ntest,1);  % to hold h values
E = zeros(ntest,1);      % to hold errors

for jtest=1:ntest
  m1 = m1vals(jtest);
  m2 = m1 + 1;
  m = m1 - 1;                 % number of interior grid points
  hvals(jtest) = (b-a)/m1;
%m = 20;
% m = 7                   %SET TO 7 FOR INITIAL TESTING..........
% m =15;
%m = 31;
% h = (b-a)/(m+1)
x = linspace(a,b,m+2);   % grid points x including boundaries
y = linspace(a,b,m+2);   % grid points y including boundaries


[X,Y] = meshgrid(x,y);      % 2d arrays of x,y values
X = X';                     % transpose so that X(i,j),Y(i,j) are
Y = Y';                     % coordinates of (i,j) point

Iint = 2:m+1;              % indices of interior points in x
Jint = 2:m+1;              % indices of interior points in y
Xint = X(Iint,Jint);       % interior points
Yint = Y(Iint,Jint);

f = @(x,y) 1.25*exp(x+y/2);         % f(x,y) function

rhs = f(Xint,Yint);        % evaluate f at interior points for right hand side
                           % rhs is modified below for boundary conditions.

utrue = exp(X+Y/2);        % true solution for test problem

% set boundary conditions around edges of usoln array:

usoln = utrue;              % use true solution for this test problem
                            % This sets full array, but only boundary values
                            % are used below.  For a problem where utrue
                            % is not known, would have to set each edge of
                            % usoln to the desired Dirichlet boundary values.


% adjust the rhs to include boundary terms:
rhs(:,1) = rhs(:,1) - usoln(Iint,1)/hvals(jtest)^2;
rhs(:,m) = rhs(:,m) - usoln(Iint,m+2)/hvals(jtest)^2;
rhs(1,:) = rhs(1,:) - usoln(1,Jint)/hvals(jtest)^2;
rhs(m,:) = rhs(m,:) - usoln(m+2,Jint)/hvals(jtest)^2;


% convert the 2d grid function rhs into a column vector for rhs of system:
F = reshape(rhs,m*m,1);

% form matrix A:
I = speye(m);
e = ones(m,1);
T = spdiags([e -4*e e],[-1 0 1],m,m);
S = spdiags([e e],[-1 1],m,m);
A = (kron(I,T) + kron(S,I)) / hvals(jtest)^2;


%uvec = A\F;   
uD=A\F;      %call uD the exact discrete solution


% Solve the linear system with a 2-cycle multigrid:
%Get PS and QS defining rowwise Gauss-Siedel for smoothing
PS=tril(A); QS=PS-A;


% Set the interpolator P, the restrictor R, and the 
% coarse grid matrix A2h
P= Pfind(m)  ; R_T= P   ;R= transpose(R_T); A2h= R*A*P  ;

% Set the initial guess u
u=ones(m*m,1);

for k = 1:11
% Take 2 steps of pre-relaxation to update u
u;
for iter = 1:2
    u = PS \ (QS*u + F);   
end

upre = u;
% Plot the error after pre-relax 
epre=uD-upre;       %for testing
% figure;
% mesh(reshape(epre,m,m))
% title('epre')
% epre_norm =norm(epre,inf)
% Set up and solve the coarse grid problem to get e2h

rh = F-A*upre; %residual from pre-relaxation
r2h= R*rh; % restrict the residual from pre-relaxation to get restricted residual
e2h= A2h\ (r2h);
% Compute interpolated coarse error you will be adding to the pre-relaxed u

correction_vector = P*e2h;

% Plot this correction to see if it looks like epre above!
%  figure;
%  mesh(reshape(correction_vector,m,m))
%  title('correction vector')

% Make the correction to get an updated u after the correction
 u = upre + correction_vector;

% Plot the error in this updated u
ecgc=uD-u;
% figure;
% mesh(reshape(ecgc,m,m))
% title('ecgc')


% Take 2 steps of post-smoothing to update u
for iter = 1:2
    u = PS \ (QS*u + F);   
end

upost= u;
% Plot the error after post-smoothing
epost=uD-upost;
% figure;
% mesh(reshape(epost,m,m))
% title('epost')
epost_norm(jtest) = norm(epost,inf)


%set uvec to upost and continue with the rest of the poisson code

uvec=upost;
% reshape vector solution uvec as a grid function and 
% insert this interior solution into usoln for plotting purposes:
% (recall boundary conditions in usoln are already set) 

usoln(Iint,Jint) = reshape(uvec,m,m);

% assuming true solution is known and stored in utrue:
err (jtest)= max(max(abs(usoln-utrue)));  
fprintf('Error relative to true solution of PDE for %d iterations = %10.3e \n',k,err)
norm_err(jtest) = norm(err,inf)
k
u;
end
end
error_table(hvals, epost_norm);

% plot results:


% plot grid:
% plot(X,Y,'g');  plot(X',Y','g')

% plot solution:
% figure;
% contour(X,Y,usoln,30,'k')
% axis([a b a b])
% daspect([1 1 1])
% title('Contour plot of computed solution')
% hold off
% 
% %% Do a mesh plot of the computed solution
% figure;
% mesh(usoln)
% title('usoln')

