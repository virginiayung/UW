function [rtilde] = mfun(r,A_sym,ms,m)
%mfun 

%This function takes as input r (which pcg sends in)
%and outputs r ?; hence, affects the solving Mr ?=r without 
%knowing M, by taking one iteration of this symmetric-Gauss Siedel method
%on original matrix system Ar ?=r with initial guess r ?^0=0

%   Detailed explanation goes here
% Decompose A = DA - LA - UA:
rtilde_0 = zeros(m^2,1);

DA = diag(diag(A_sym));   % diagonal part of A
LA = DA - tril(A_sym);    % strictly lower triangular part of A (negated)
UA = DA - triu(A_sym);    % strictly upper triangular part of A (negated)
 
% set up iteration matrix:

      M = DA - LA; %forward GS
      N = UA;
      
rtilde=rtilde_0;
for i=1:ms
     rtilde_1=M\(N*rtilde + r);
end

      P = DA - UA; %backward GS
      Q = LA;
      
rtilde=rtilde_1; 
for iter = 1:ms
    rtilde = P\ (Q * rtilde +r);
end


end


