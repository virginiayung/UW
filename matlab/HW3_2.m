clear all; close all;
eps= 1/(10^4)
A= [1, 1, 1, 1; eps,eps, 0, 0;  eps, 0,  eps, 0;  eps, 0, 0,  eps];

[ma,na]=size (A)


for j = 1: na
    Vcgs(:,j) = A(:,j)
    for i = 1 : j-1
        Rcgs(i,j) = (Qcgs(:,i)')* A(:,j)
        Vcgs(:,j) = Vcgs(:,j) - Rcgs(i, j)* Qcgs(:,i)
    end
    Rcgs(j, j) = norm(Vcgs(:,j))
    Qcgs(:,j) = Vcgs(:,j) / Rcgs(j, j)
end


errorcgs = norm ( ((Qcgs).'* Qcgs) - eye(4))


[mcgs,ncgs]=size (Qcgs)

% Twice applied GS :
% A = Qcgs * Rcgs
%   = (Qtsgs * R1)*Rcgs
%   = Qtsgs * (R1*Rcgs)
%   = Qtsgs * Rtsgs
% ===> Rtsgs = R1* Rcgs


for j = 1: ncgs
    Vtsgs(:,j) = Qcgs(:,j)
    for i = 1 : j-1
        R1(i,j) = (Qtsgs(:,i)')* Qcgs(:,j)
        Vtsgs(:,j) = Vtsgs(:,j) - R1(i, j)* Qtsgs(:,i)
    end
    R1(j, j) = norm(Vtsgs(:,j))
    Qtsgs(:,j) = Vtsgs(:,j) / R1(j, j)
end

Rtsgs = R1*Rcgs;

errortsgs = norm( ((Qtsgs).'* Qtsgs) - eye(4))


[Qqr, Rqr]= qr(A)

errorqr = norm ( ( (Qqr).'* Qqr) - eye (4))

ratiocgs = errorcgs / errorqr

ratiotsgs = errortsgs / errorqr


save a.dat A -ascii
save ratiocgs.dat ratiocgs -ascii

save rcgs.dat Rcgs -ascii
save ratiotsgs.dat ratiotsgs -ascii
