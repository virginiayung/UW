n=64
A=sparse(n,n)
for i = 2:n-1
    A(i,i)=2
    A(i,i+1)=-1
    A(i,i-1)=-1
end

for i = n
    A(i,i)=2
    A(i,i-1)=-1
end


for i=1
    A(i,i)=2
    A(i,i+1)=-1
end

count number of nonzeros in A
w=full(sum(sum(A~=0)))

save b01.dat w -ascii

save the vectors of row indices
[r,c,v]=find(A)


save b02.dat r -ascii

save the vectors of column indices

save b03.dat c -ascii
save the values
save b04.dat v -ascii

