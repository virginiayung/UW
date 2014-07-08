n=1000
    T = 2*diag(ones(n,1)) + -1*diag(ones(n-1,1),1) +-1*diag(ones(n-1,1),-1)

    D=diag(diag(T))
    L=tril(T)-D
    U= triu(T)-D
    
     J=inv(D)*(L+U)
    eig(J)

    % inv(D)*T = 1/2* T
   % eigenvalue of  eye(n)-inv(D)*T = 1-.5(lamda of T)
    %eye(n)-inv(D)*T
    
    
     G=-inv(D+L)*U
     %eig(G)
     norm(G)

