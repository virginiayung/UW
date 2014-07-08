!Trefethen  13.3 comparison of two graphs: p=coefficients, p2=(x-2)^9


x= 1.920:0.001:2.080
p = x.^9-18*x.^8+144*x.^7-672*x.^6+2016*x.^5-4032*x.^4+5376*x.^3-4608*x.^2+2304*x-512
p2=(x-2).^9
plot(x,p,x,p2,'r--')


