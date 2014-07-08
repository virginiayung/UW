clear all; close all;

y(1)=1
y(2)=1

for n=2:49
    y(n+1)=y(n)+y(n-1)
    
end

y(50)

y50=y(50)

save y50.dat y50 -ascii

for i=1:50
    a1(i)=1
    a2(i)=i
end

A=[a1.' a2.']
b=[log(y.')]

[q,r]=qr(A,0)

c=r\(transpose(q)*b)
c1=c(1)
c2=c(2)

save c1.dat c1 -ascii
save c2.dat c2 -ascii
for m=1:50
    z(m) = c1 + (c2*m)
end
z=z.'
exp(z)

plot(z)

beta= exp(c2)

(1+sqrt(5))/2

save beta.dat beta -ascii






