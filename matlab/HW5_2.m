clear all; close all;

A=[21 67 88 73; 76 63 7 20; 0 85 56 54; 19.3 43 30.2 29.4];
b=[141;109;218;93.7];

As=single(A);
Ad=double(A);
bd=double(b);



[L,U]=lu(As);
Ls=single(L);
Us=single(U);
L=double(Ls);

save Ls.dat L -ascii -double

x=Us\(Ls\b);
x1=double(x);

save x1.dat x1 -ascii -double

r=b-Ad*x1

rs=single(r)
% %solve Az=r using LU to obtain  x+z
counter =1

while (norm(rs) > 0)
    
    z=Us\(Ls\rs)
    x=x+z
    x=double(x)
    counter=counter+1
    r=b-Ad*x
    rs=single(r)
   

end
x=double(x)
save xfinal.dat x -ascii -double

save solves.dat counter -ascii -double



















