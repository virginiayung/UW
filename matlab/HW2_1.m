B=zeros(11,3);
n=12;

%populating matrix
% for i=1:3
%     for j=1:2
%     B(i,j)=i*n 
%     end
% end 


for i=1:11
    r = (9+i)/100
    i
    for j=1:3
        B(i,j)=(r*1000*((1+r/12)^(n*5*(j+2))))/(n*(((1+r/n)^(n*5*(j+2)))-1))
        j
    end
  
end
save a01.dat B -ascii


%TEST
%b=(.11*1000*((1+.11/12)^(12*15)))/(12*(((1+.11/12)^(12*15))-1))