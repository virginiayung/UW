clear all; close all;

randn('state',1);
m=200;
A = 2*eye(m) + 0.5*randn(m)/sqrt(m);
[M,n]=size(A);

b=ones(m,1);

q(:,1) = b/norm(b);

for n = 1:10
    
    v = A*q(:,n);
    
    for j= 1:n
        h(j,n) = q(:,j)'*v;
        v = v-h(j,n)*q(:,j);
    end
    h(n+1, n)=norm(v);
    q(:,n+1) = v/ h(n+1,n);
    
end

A
h
q


save a.dat A -ascii
save h10.dat h -ascii
save q10.dat q -ascii

