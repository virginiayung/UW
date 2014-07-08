function P = Pfind(m)
%
% m is the number of interior grid points in both the
% x and y directions.  
%
%IMPORTANT: (m+1) should be a power of 2.  Set m in poisson.m to be 7
%           while you are testing, then make it 15, and 31 later
%           Note that m=20 in poisson.m right now!!!!!!!!!!!
%
%           nf = number of fine grid interior grid points. 
%           nc = number of coarse grid interior grid points.
%           P is nf by nc  and is the prolongation operator matrix
%           Matrix A in poisson.m should be nf x nf
%           The coarse grid matrix RAP should be nc x nc that you build
%            
%           This program finds P for you.

   mp1=m+1;       %number of subintervals on fine grid including boundary points
   mcp1=(m+1)/2;  %number of subintervals on coarse grid including boundary points
   mc=mcp1-1;     %number of interior points on coarse grid in each direction
   
   nf=m^2;    
   nc=mc^2;
   P=spalloc(nf,nc,nf*4);         %at most 4 nonzeros in each row of P
%
% set the Copy connection
   for i=2:2:(m-1)
       for j=2:2:(m-1)
           iP=(j-1)*m +i;         %row in matrix P for fine grid point (i,j)
           jP= (j/2 -1)*mc+i/2;   %column in matrix P for coarse grid point (i/2,j/2)
           P(iP,jP)=1.0;          %copy
       end
   end

% set the midpoint of East-West edge
   for j=2:2:(m-1)
       i=1;
       iP=(j-1)*m + i;
       East=(j/2 -1)*mc + (i+1)/2;
       P(iP,East)=.5;
       for i=3:2:(m-2)
           iP=(j-1)*m+i;
           East=(j/2 -1)*mc + (i+1)/2;
           West=(j/2 -1)*mc + (i-1)/2;
           P(iP,East)=.5;
           P(iP,West)=.5;
       end
       i=m;
       iP=(j-1)*m + i;
       West=(j/2 -1)*mc + (i-1)/2;
       P(iP,West)=.5;
    end

% set the midpoint of North-South edge
   for i=2:2:(m-1)
       j=1;
       iP=(j-1)*m + i;
       North=((j+1)/2 -1)*mc + i/2;
       P(iP,North)=.5;
       for j=3:2:(m-2);
           iP=(j-1)*m+i;
           North=((j+1)/2 -1)*mc + i/2;
           South=((j-1)/2 -1)*mc + i/2;
           P(iP,North)=.5;
           P(iP,South)=.5;
       end
       j=m;
       iP=(j-1)*m + i;
       South=((j-1)/2 -1)*mc + i/2;
       P(iP,South)=.5;
    end

% set the center of coarse cell

%% set the NE connection
    for i=1:2:(m-2)
        for j=1:2:(m-2)
            iP=(j-1)*m + i;
            NE=((j+1)/2 - 1)*mc + (i+1)/2;
            P(iP,NE)=.25;
        end
    end

%% set the NW connection
    for i=3:2:m
        for j=1:2:(m-2)
            iP=(j-1)*m + i;
            NW=((j+1)/2 - 1)*mc + (i-1)/2;
            P(iP,NW)=.25;
        end
    end

%% set the SW connection
    for i=3:2:m
        for j=3:2:m
            iP=(j-1)*m + i;
            SW=((j-1)/2 - 1)*mc + (i-1)/2;
            P(iP,SW)=.25;
        end
    end

%% set the SE connection
    for i=1:2:(m-2)
        for j=3:2:m
            iP=(j-1)*m + i;
            SE=((j-1)/2 - 1)*mc + (i+1)/2;
            P(iP,SE)=.25;
        end
    end
%
end
