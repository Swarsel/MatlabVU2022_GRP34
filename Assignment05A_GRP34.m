preamble
%
[mya,myb,myn,mynn]=deal(0,8,1001,501);
myfun=@(x) (sin(x.^2).*exp(-x/5));
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
    if mod(n,2)
        s_vec=[1 repmat([2 4], 1, (n-3)/2) 2 1];
        I=sum(s_vec.*y)*s(1)/3;
        return
    else
        I=trapz(x, y);
    end
else
    error('All conditions have to be met!')
end
end

function [A,funz,h]=AreaZeros(funh,a,b,n,nn)
funsp=@(X, Y) (X(sign(Y(1:end-1)) ~= sign(Y(2:end))));
x=linspace(a,b,n);
h=figure(1)
clf
funct=plot(x,funh(x),'DisplayName','$f(x)=\sin(x^2/2)\cdot\exp(-x/5)$');
hold on
grid on
plot(x,zeros(size(x)))
A=simpson(x,funh(x));
sts=funsp(x,funh(x));
funz=unique(arrayfun(@(z) fzero(funh,z),[sts b]));
plot(funz,0*funz,'o','markersize',10);

secx=linspace(funz(3),funz(4),nn);
[X, Y]=meshgrid(secx,funh(secx)); 
c(1)=trapz(diag(X),diag(X.*Y))/trapz(diag(X),diag(Y));
c(2)=trapz(diag(Y),diag(Y.*X))/trapz(diag(Y),diag(X));
blabel=['$Barycenter: ($' num2str(c) '$)$'];
bary=plot(c(1),c(2),'x','markersize',10,'DisplayName',blabel);
fill(secx,funh(secx),'cyan','FaceAlpha',0.3)
xlabel('$x$')
ylabel('$y$')
legend([funct bary])
hold off
end
