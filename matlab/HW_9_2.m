clear all; close all;

randn('state',1);
m=200;
A = 2*eye(m) + 0.5*randn(m)/sqrt(m);
A = A.'*A;
[mb,nb]=size(A);

b=ones(m,1);

n_max = 400
% setting beta_0 and q0
beta_0 = 0
q_0 = zeros(m,1)
q(:,1) = b/norm(b); % setting q1

for n = 1:1
    v = A * q(:,n);
    alpha(:,n) = q(:,n).' * v
    v = v - beta_0*q_0 - alpha(:,n)*q(:,n)
    beta(:,n) = norm(v)
    q(:,n+1) = v/ beta(:,n)
end   

for n = 2: 10
    v = A * q(:,n);
    alpha(:,n) = q(:,n).' * v
    v = v - beta(:,n-1)*q(:,n-1) - alpha(:,n)*q(:,n)
    beta(:,n) = norm(v)
    q(:,n+1) = v/ beta(:,n)
    
end

% A = gallery('tridiag',c,d,e) returns the tridiagonal matrix with subdiagonal
% c, diagonal d, and superdiagonal e. Vectors c and e must have length(d)-1

Tn = gallery('tridiag',beta(:,1:n-1),alpha,beta(:,1:n-1)) 
t10 = full(Tn) %Saving sparse arrays to an ASCII file is unsupported.



save a2.dat A -ascii
save t10.dat t10 -ascii
save q10.dat q -ascii





