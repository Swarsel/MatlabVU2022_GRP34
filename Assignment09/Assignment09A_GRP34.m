preamble;
syms y(x)
Dy=diff(y);
D2y=diff(y,2);
D3y=diff(y,3);

[xlow, xupp] = deal(1,10);
[a,b,c,d] = deal(1,-2,3,4);

eq=a*x^3*D3y+b*x^2*D2y+c*x*Dy+d*y;
[eqs,vars]=reduceDifferentialOrder(eq,y(x));
[M,F]=massMatrixForm(eqs,vars);
f=M\F;
fh=odeFunction(f,vars);

yini=x^2;
Dyini=simplify(diff(yini));
D2yini=simplify(diff(Dyini));
yinit=matlabFunction([-yini;-Dyini;-D2yini]);

bv = [1;2;-2];
bcres=@(ylow,yupp,bv) [ylow(1)-bv(1);yupp(1)-bv(2); yupp(2)+bv(2)];
xinit=linspace(xlow,xupp,201);
solinit=bvpinit(xinit,yinit);
solnum=bvp4c(fh,@(ylow,yupp) bcres(ylow,yupp,bv),solinit);

xs=solnum.x;
ys=solnum.y(1,:);
ys1=solnum.yp(1,:);
ys2=solnum.yp(2,:);
ys3=solnum.yp(3,:);
lhs=a*xs.^3.*ys3+b*xs.^2.*ys2+c*xs.*ys1+d*ys;
disp(['max(abs(lhs)): ',num2str(max(abs(lhs)))])

figure(1)
clf
hold on
h(1)=plot(xs,ys,'displayname', "$y(x)$");
h(2)=plot(xs,ys1,'displayname',"$y'(x)$");
h(3)=plot(xs,ys2,'displayname',"$y''(x)$");
h(4)=plot(xs,ys3,'displayname',"$y'''(x)$");
h(5)=plot(xs,lhs,'k--', 'displayname',"Proof");
box on
grid on
xlabel('$x$')
ylabel('$y(x)$')
xlim([xlow xupp])
htit=title("$x^3 y''' - 2x^2y'' + 3xy' + 4y = 0, \;\;\;\; y(1) = 1, y(10) = 2, y'(10) = -2$",'fontsize',16);
yl=get(gca,'ylim');
set(htit,'position',get(htit,'position')+[0 0.01*diff(yl) 0]);
legend(h(:),'location','northwest','fontsize',14)
drawnow






