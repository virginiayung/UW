clear all; close all;

B=load('MatrixB.dat');


%A=[1 4 5; 4 2 6; 5 6 3] Test matrix
 [R, C]= size(B);
       for i=1:R
           L(i,1)=B(i,1);
           U(i,i)=1;
       end
       
       for j=2:R
            U(1,j)=B(1,j)/L(1,1);
            U1=U
         
           save u1.dat U1 -ascii

       end
       
      for i=2:R
            for j=2:i
                L(i,j)=B(i,j)-L(i,1:j-1)*U(1:j-1,j);
           end
           
           for j=i+1:R
               U(i,j)=(B(i,j)-L(i,1:i-1)*U(1:i-1,j))/L(i,i);
              
           end
            if i < 3
               U2=U
               save u2.dat U2 -ascii
            end
          
      end
      L
      save lfinal.dat L -ascii
      
      U
      save ufinal.dat U -ascii
      
       
    
       