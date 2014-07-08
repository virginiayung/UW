clear all; close all;
!A=[ 1 0 0;1 1 1; 1 2 4;1 3 9]
A=[1 0 0;1 1 1;1 3 9;1 6 36]
!b=[5;4;6;9]
b=[2;3;7;12]
[q,r] = qr(A,0)
q
r

x=r\(transpose(q)*b)
y = x(1,1) + (x(2,1)*9)