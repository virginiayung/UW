% AMATH 585 HW 1
% 1.2 a
%A= [ 1, 1, 1, 1, 1; -2, -1, 0, 1, 2; 2*h^2, 0.5*h^2, 0, 0.5*h^2, 2*h^2; -8/6*h^3, -1/6*h^3, 0, 1/6*h^3, 8/6*h^3]
A= [ 1, 1, 1, 1, 1; -2, -1, 0, 1, 2; 2, 0.5, 0, 0.5, 2; -8/6, -1/6, 0, 1/6, 8/6; 16/24, 1/24, 0,1/24, 16/24]
b = [0;0;1;0;0]

W = [1, 1,1; 0,-1,-2;0,1/2,2]
    y= [0;1;0]

clear all; close all;


% 1.2b
k = 2
j=[-2:2]
n = length(j);


fdstencil(k,j)
c = fdcoeffF(2,0,j)

err1 = c*(j(:).^(n+1)) / factorial(n+1)


% 1.2c

% Example 1.1 
% Table 1.1 and Figure 1.2 of  http://www.amath.washington.edu/~rjl/fdmbook

%u(x)=sin(2x)
utrue = -4*sin(2);
hvals = logspace(-1,-4,13);
E3u = [];

% table headings:
disp(' ')
disp('       h             Error            PreE       Error-PrE')

for i=1:length(hvals)
   h = hvals(i);
   % approximations to u''(1):

   PreE(i)=  -0.0111111 * h^4*(-64*sin(2));
   xpts = 1 + h*(-2:2)';
   %D3u = (1/(h^2))*fdcoeffF(2,0,j) * sin(2*xpts);
   D3u = fdcoeffF(2,1,xpts) * sin(2*xpts);
   
  
   % errors:
   
   E3u(i) = D3u - utrue;
   Diff(i)=E3u(i)-PreE(i);

   % print line of table:
   disp(sprintf('%13.4e   %13.4e  %13.4e  %13.4e',...
                 h,E3u(i),PreE(i), Diff(i)))
   end

% plot errors:
clf

axis([5e-4 .1 1e-25 1e-4])
hold on
loglog(hvals,abs(E3u),'o-')
hold off
