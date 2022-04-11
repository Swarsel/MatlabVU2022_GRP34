preamble
myfun=@(X) (sin(X.^2).*exp(-X/5));
sp=@(X, Y) (X(sign(circshift(Y,-1)) ~= sign(Y)));

[area, zeros] = AreaZeros(-4, -2, 1000, myfun, sp)

function [A,Z]=AreaZeros(a,b,n,funh,funsp)
x=linspace(a,b,n);
figure(1)
clf
plot(x,funh(x))
hold on
plot(x,zeros(size(x)))
grid on
A=trapz(x,funh(x))
sts=funsp(x,funh(x));
if sts(end) == x(end)
    sts=sts(1:end-1); % neccessary due to circshift
end
Z=arrayfun(@(z) fzero(funh,z),sts);
plot(Z,0*Z,'o','markersize',10)
hold off
end
