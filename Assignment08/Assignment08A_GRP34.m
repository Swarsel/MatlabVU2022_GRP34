preamble;
k0=0.05; q0=0.95; M0=10; x0=-300; y0=5;
syms x k M; syms y(x) yq(x);
eqstr="y'-k*sqrt(y)*(1-y/M)";
a0=3;b0=2;const=[a0 b0]; 
inicond=[y(1)==2]; 
rg=[0 10]; 
titstr="3y'+2y=0,\ y(1)=2";
Dy=diff(y,x,1);
eqs=strrep(eqstr,"y'","Dy");
eq=eval(eqs);
ysg(x)=dsolve(eq==0)
eq=subs(eq, [k M], [k0 M0]);
ysp(x)=simplify(dsolve(eq==0,y(0)==y0))
assume(x,'positive');
figure(1);
clf;
eqd=diff(ysp(x),x,1)==0
m=arrayfun(@(a) ~isempty(solve(a,x)), eqd);
yq(x)=lhs(eqd(m))
preamble;
k0=0.05; q0=0.95; M0=10; x0=-300; y0=5;
syms x k M; syms y(x) yq(x);
eqstr="y'-k*sqrt(y)*(1-y/M)";
a0=3;b0=2;const=[a0 b0]; 
inicond=[y(1)==2]; 
rg=[0 10]; 
titstr="3y'+2y=0,\ y(1)=2";
Dy=diff(y,x,1);
eqs=strrep(eqstr,"y'","Dy");
eq=eval(eqs);
ysg(x)=dsolve(eq==0)
eq=subs(eq, [k M], [k0 M0]);
ysp=simplify(dsolve(eq==0,y(0)==y0))
assume(x,'positive');
figure(1);
clf;
eqd=diff(ysp,x,1)==0;
m=arrayfun(@(a) ~isempty(solve(a,x)), eqd);
yq(x)=ysp(m);

syms x real; %reset x to include negative values
xa=solve(yq(x0)==yq(x),x);
xa=xa(xa~=x0); %throw away redunant coordinate
x1=round(vpa(xa),3)
fplot(yq,[x0 double(x1)]);
syms x real; %reset x to include negative values
xa=solve(yq(x0)==yq(x),x);
xa=xa(xa~=x0); %throw away redunant coordinate
x1=round(vpa(xa),3)
fplot(yq,[x0 double(x1)]); hold on;
xmin=round(vpa(solve(diff(yq(x),x,1)==0,x)),3)
ymin=round(vpa(yq(xmin)),3)
xinf=round(vpa(solve(diff(yq(x),x,2)==0,x)),3)
yinf=round(vpa(yq(xinf)),3)
minstr=strcat(['Min: (x=$' num2str(double(xmin)) '$, y=$' num2str(double(ymin)) '$)']);
infstr=strrep(minstr, 'Min', 'Inf1')
plot(xmin, ymin, 'Marker', 'o', 'MarkerSize', 10,'DisplayName',minstr);
scatter(xinf, yinf, 'Marker', 'x','DisplayName','Inflection points')
legend();



