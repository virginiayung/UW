clear all;

%%% 1a

k=0

for j=1:502

    k = k+(-1)^(j+1)/(2*j-1)

end

save a1.dat k -ascii

%%% 1b

m=0;

for j=1:500

    m = m+(1/(((2*j-1)^2)*(2*(j+1)-1)^2))

end
m
save a2.dat m -ascii

%%%2a

s=0;

for j=1:20
    s=s+(1/(j)^2)
    
end
s
save s20.dat s -ascii

%%%2b

s=0;

for j=1:20
    s=s+(1/(j)^2)
    
end
e=abs(sqrt(6*s)-pi)

save e20.dat e -ascii
   

%%%2c
n = 1;
r = 0;
while (1)
    r = r+(1/(n^2))
    error = abs(sqrt(6*r)-pi)

    if (error < 10^(-4))
        break
    end
    
    n = n+1
end
n
save n04.dat n -ascii

% 
% error = abs(sqrt(6)-pi)
% n = 0
% r = 0
% 
% while (error >= 10^(-4))
%     n = n+1
%     r = r+(1/(n^2))
%     error = abs(sqrt(6*r)-pi)
% end
% n