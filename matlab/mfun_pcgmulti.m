

function [rtilde] = mfun_pcgmulti(r,A,m)
%mfun 

%This function takes as input r (which pcg sends in)
%and outputs r ?; hence, affects the solving Mr ?=r without 
%knowing M, by taking one iteration of this symmetric-Gauss Siedel method
%on original matrix system Ar ?=r with initial guess r ?^0=0

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


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Solve the linear system with a 2-cycle multigrid:
%Get PS and QS defining rowwise Gauss-Siedel for smoothing
PS=tril(A); QS=PS-A;


% Set the interpolator P, the restrictor R, and the 
% coarse grid matrix A2h
P= Pfind(m)  ; R_T= P   ;R= transpose(R_T); A2h= R*A*P  ;

% Set the initial guess u
u=zeros(m*m,1);

% Take 2 steps of pre-relaxation to update u
for iter = 1:2
    u = PS \ (QS*u + r);   
end

upre = u;

% Set up and solve the coarse grid problem to get e2h

rh = r-A*upre; %residual from pre-relaxation
r2h= R*rh; % restrict the residual from pre-relaxation to get restricted residual
e2h= A2h\ (r2h);
% Compute interpolated coarse error you will be adding to the pre-relaxed u

correction_vector = P*e2h;

% Make the correction to get an updated u after the correction
 u = upre + correction_vector;


% Take 2 steps of post-smoothing to update u
for iter = 1:2
    u = PS \ (QS*u + r);   
end

upost= u;


%set uvec to upost and continue with the rest of the poisson code

uvec=upost;


rtilde = upost;

end


