A=[1 2 -1 0; 2 4 -2 -1; -3 -5 6 1; -1 2 8 -2]
P1=[ 0 0 1 0; 0 1 0 0; 1 0 0 0; 0 0 0 1]
L1=[1 0 0 0;2/3 1 0 0; 1/3 0 1 0; -1/3 0 0 1]
P2=[1 0 0 0;0 0 0 1;0 0 1 0; 0 1 0 0]
L2 =[1 0 0 0; 0 1 0 0; 0 -1/11 1 0; 0 -2/11 0 1]
P3 =[ 1 0 0 0; 0 1 0 0; 0 0 0 1; 0 0 1 0]
L3=[1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 -1/2 1]

P3*L2*P2*L1*P1*A

L3*P3*L2*P2*L1*P1*A

P3*P2*P1

L3*(P3*L2*inv(P3))*(P3*P2*L1*inv(P2)*inv(P3))*A


P3*P2*L1*inv(P2)*inv(P3)