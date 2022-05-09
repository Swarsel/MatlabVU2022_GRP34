preamble
%
[mya,myb,myn,mynn]=deal(0,8,1001,501);
myfun=@(x) (sin((x.^2)./2).*exp(-x./5));
[myA,myzeros,myh]=AreaZeros(myfun,mya,myb,myn,mynn);
myA
myzeros
return

function I=simpson(x,y)
n=size(x,2);
s=diff(x);
check_a=(isnumeric(x) & isnumeric(y));
check_b=(n==size(y,2));
% Due to probably computing errors, the step size is never exactly equal
check_c=range(s)<=10^(-14);
if (check_a & check_b) & check_c
    if mod(n,2) % Check for odd gridpoints
        s_vec=[1 repmat([2 4], 1, (n-3)/2) 2 1];
        I=sum(s_vec.*y)*s(1)/3; % area calculation
        return
    else
        I=trapz(x, y);
    end
else
    error('All conditions have to be met!')
end
end

function [A,funz,h]=AreaZeros(funh,a,b,n,nn)
funsp=@(X, Y) (X(sign(Y(1:end-1)) ~= sign(Y(2:end)))); % starting points
x=linspace(a,b,n); % create grid
h=figure(1)
clf
funct=plot(x,funh(x),'DisplayName','$f(x)=\sin(x^2/2)\cdot\exp(-x/5)$');
hold on
grid on
plot(x,zeros(size(x)))
A=simpson(x,funh(x)); % Area calculation
sts=funsp(x,funh(x)); % starting points
funz=unique(arrayfun(@(z) fzero(funh,z),[sts b])); % calculate zeros
zero = plot(funz,0*funz,'o','markersize',10,'DisplayName','$Zeros$'); % plot zeros

secx = linspace(funz(3),funz(4),nn); % grid for barycenter-area
sa = simpson(secx, funh(secx)); % Barycenter area
c(1) = simpson(secx, secx.*funh(secx))/sa; % integrals simplify to these
c(2) = simpson(secx, funh(secx).^2./2)/sa;
blabel=['$Barycenter: ($' num2str(c) '$)$']; % plot everything...
bary=plot(c(1),c(2),'x','markersize',10,'DisplayName',blabel);
fill(secx,funh(secx),'cyan','FaceAlpha',0.3)
xlabel('$x$')
ylabel('$y$')
title('$Zeros,\ Area\ and\ Barycenter$')
legend([funct bary zero])
hold off
end
