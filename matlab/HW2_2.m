%EX 2 PART 1
n = 64
A = sparse(n,n)
for i = 2:n-1
    A(i,i) = 2
    A(i,i+1) = -1
    A(i,i-1) = -1
end

for i = n
    A(i,i) = 2
    A(i,i-1) = -1
end


for i=1
    A(i,i) = 2
    A(i,i+1) = -1
end

%count number of nonzeros in A
w=full(sum(sum(A~=0)))

save b01.dat w -ascii

%save the vectors of row indices
[r,c,v]=find(A)


save b02.dat r -ascii

%save the vectors of column indices

save b03.dat c -ascii
%save the values
save b04.dat v -ascii


%PART 2
n = 128
B = sparse(n^2, n^2)
for l = 1:n
    for m = 1:n
        i = l+(m-1)*n;
        B(i,i)=4;
        if l+1 < n+1
            j1 = (l+1) +(m-1)*n;
            B(i,j1)=-1;
        elseif l+1< n+2
            i = l+(m-1)*n;
            B(i,i)=4;     
        else break
        end
        
        if l-1 > 0
            j2 = (l-1) + (m-1)*n;
            B(i,j2)=-1;
        elseif l-1 > -1
            i = l+(m-1)*n;
            B(i,i)=4; 
        else break
        end
        
        if m+1 < n+1
            j3 = l +(m+1-1)*n;
            B(i,j3)=-1;
        elseif m+1 < n+2
            i = l+(m-1)*n;
            B(i,i)=4 ; 
            
        else break
        end
        l
        m
        i
        if m-1 > 0
            j4 = l +((m-1)-1)*n;
            B(i,j4)=-1;
          
        elseif m-1 > -1
            i = l+(m-1)*n;
            B(i,i)=4;  
        else break
        end
        
    end
        
        
end
%count number of nonzeros in A

k=full(sum(sum(B~=0)))

save b05.dat k -ascii


%save the vectors of row indices
[r2,c2,v2]=find(B)


save b06.dat r2 -ascii

%save the vectors of column indices

save b07.dat c2 -ascii
%save the values
save b08.dat v2 -ascii

    

