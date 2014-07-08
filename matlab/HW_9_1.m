clear all; close all;

randn('state',1);
m=200;
A = 2*eye(m) + 0.5*randn(m)/sqrt(m);
[mb,nb]=size(A);

b=ones(m,1);
tao = 10^(-10) 

n_max = 400



q(:,1) = b/norm(b);

for n = 1:n_max
    
    v = A*q(:,n);
    
    for j= 1:n
        h(j,n) = q(:,j)'*v;
        v = v-h(j,n)*q(:,j);
    end
    h(n+1, n) = norm(v);
    % least square find y to minimize norm(Hn*y - norm(b)*e1)
    y = h\(norm(b)*eye(n+1,1))
    x = q*y
  
    q(:,n+1) = v/ h(n+1,n);
    if norm(b-A*x) <= tao*norm(b)
        break
    end
end

iter = n

save a.dat A -ascii
save x.dat x -ascii
save iter.dat iter -ascii
save h.dat h -ascii


