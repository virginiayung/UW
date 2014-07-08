syms x
f(x) = sin(2*x);
df = diff(f,2)


 xpts = 1 + h*(-2:1)'
   D3u = fdcoeffF(1,1,xpts) * sin(xpts)