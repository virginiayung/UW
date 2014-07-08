clear all; close all;
h=.25
A_1= [-3*h/2, 2*h, -h/2, 0, 0; 1, -2, 1, 0, 0; 0, 1, -2, 1, 0; 0, 0, 1, -2, 1; 0, 0, 0, 0, h^2]
A_2 = 1/(h^2)*A_1
A_3 = 1/(h^2)*[h^2, 0, 0, 0, 0; 1, -2, 1, 0, 0; 0, 1, -2, 1, 0; 0, 0, 1, -2, 1; 0, 0, 0, 0, h^2]
B= inv(A_3)

x = [0 .25 .5 .75 1]
F = [0;.25;.5;.75;0]

G = B/.25


%%plot(x, G(1:5,1), '--b')
%%hold on;
plot(x, G(1:5,2), '-r')
hold on;
plot(x, G(1:5,3), '-g')
hold on;
plot(x, G(1:5,4), '-c')
%%hold on;
%%plot(x, G(1:5,5), '--m')

title('Greens Function versus X',... 
  'FontWeight','bold')



GF1= G(1:5,1)*0.25*F(1)
GF2= G(1:5,2)*0.25*F(2)
GF3= G(1:5,3)*0.25*F(3)
GF4= G(1:5,4)*0.25*F(4)
GF5= G(1:5,5)*0.25*F(5)

G2=G(1:5,2)*.25*.25
G3=G(1:5,3)*.50*.25
G4=G(1:5,4)*.75*.25

% %GreenFunction
% 
% for i = 1:5
%     if x(i) < F(i)
%         GF= x(i)*(F(i:1)-1)
%         plot(x(i), GF)
%     else
%      GF = (x(i)-1)*F(i)
%      
%       plot(x(i), GF)
%       
%     end
% end
%         

