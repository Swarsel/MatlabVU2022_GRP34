% UNFINISHED VERSION, PLEASE DO NOT SUBMIT YET
preamble
myfun=@(X) (sin(X.^2).*exp(-X/5));
sp=@(X, Y) (X(sign(circshift(Y,-1)) ~= sign(Y)));

[area, zeros] = AreaZeros(0, 3.5, 1000, myfun, sp)

function I=simpson(x,y)
n=size(x);
s=unique(diff(x));
check_a=isnumeric(x) & isnumeric(y);
check_b=n == size(y);
check_c=size(s)==1;
if (check_a & check_b) & check_c
    if mod(n,2)
        s_vec=[1 repmat([2 4], 1, (n-3)/2) 2 1];
        I=sum(s_vec.*y)*s/3;
        return
    else
        I=trapz(x, y);
    end
else
    error('All conditions have to be met!')
end
end

function [A,Z]=AreaZeros(a,b,n,funh,funsp)
x=linspace(a,b,n);
figure(1)
clf
plot(x,funh(x))
hold on
plot(x,zeros(size(x)))
grid on
A=trapz(x,funh(x));
sts=funsp(x,funh(x));
if sts(end) == x(end)
    sts=sts(1:end-1); % neccessary due to circshift
end
Z=arrayfun(@(z) fzero(funh,z),sts);
plot(Z,0*Z,'o','markersize',10)
% This barycenter-algorithm only works well for big n:
secx=x(find(x==sts(3)):find(x==sts(4)));
[X, Y]=meshgrid(secx,funh(secx)); 
c(1)=trapz(diag(X),diag(X.*Y))/trapz(diag(X),diag(Y));
c(2)=trapz(diag(Y),diag(Y.*X))/trapz(diag(Y),diag(X));
plot(c(1),c(2),'x','markersize',10)
hold off
end
