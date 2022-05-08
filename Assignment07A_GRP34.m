preamble;
syms x y
f=x^2-10*x+26;
g=-x^2/2+5*x-7;
h=x^2-y^2;
isc=solve(f-g)
A=int(int(h,y,f,g),x,isc(1),isc(2))
isc=double(isc);
hf=matlabFunction(h);
fh=matlabFunction(f);
gh=matlabFunction(g);
A_num=integral2(hf,isc(1),isc(2),fh,gh)
rel_error=double((A-A_num)/A)

fig=figure(1);
clf
hold on
fname=[strcat("$f(x)=",latex(f),"$") strcat("$g(x)=",latex(g),"$")];
lstring=arrayfun(@(fun, fn) fplot(fun,[3 7],'DisplayName',fn),[f g],fname);
lstring(3)=plot(isc,fh(isc),'x','Color','red','MarkerSize',20,'DisplayName','$Intersections$');
xvec=[linspace(isc(1),isc(2),500) linspace(isc(2),isc(1),500)];
yvec=[gh(xvec(1:500)) fh(xvec(501:1000))];
astring=strcat(['$Integral\ over\ area:' num2str(A_num) '$']);
lstring(4)=fill(xvec,yvec,'blue','FaceAlpha',0.3,'DisplayName',astring);
xlabel('$x$');
ylabel('$y$');
title(strcat(['$h(x,y)=' latex(h) '$ integrated over area between $f(x)$ and $g(x)$']));
legend(lstring);