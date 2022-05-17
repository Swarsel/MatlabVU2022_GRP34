preamble;
k0=0.05; q0=0.95; M0=10; x0=-300; y0=5;
figure(1);
clf;
syms x; syms k M set constant; syms y(x) yq(x);
eqstr="y'-k*sqrt(y)*(1-y/M)";
Dy=diff(y,x,1);
eqs=strrep(eqstr,"y'","Dy");
eq=eval(eqs);
ysg=dsolve(eq==0);
yg(x)=ysg(~strcmp(symFunType(diff(ysg,x,1)),"integer"));
disp(['yg(x)=' char(yg(x))]);
eq=subs(eq, [k M], [k0 M0]);
ysp=simplify(dsolve(eq==0,y(0)==y0));
assume(x,'positive');
eqd=diff(ysp,x,1)==0;
m=arrayfun(@(a) ~isempty(solve(a,x)), eqd);
yq(x)=ysp(m); %select specified solution
disp(['yq(x)=' char(yq(x))]);
syms x real; %reset x to include negative values
xa=solve(yq(x0)==yq(x),x);
xa=xa(xa~=x0); %throw away redunant coordinate
x1=round(vpa(xa),3)
ystring=strcat(['$y_q(x)=' char(yq) '$']);
ystring=strrep(ystring,"^(1/2)","^{1/2}");
fplot(yq,[x0 double(x1)],'DisplayName',ystring); hold on;
% Find special points
xmin=round(vpa(solve(diff(yq(x),x,1)==0,x)),3);
ymin=round(vpa(yq(xmin)),3);
disp(['(xmin ymin) = (' char(xmin) ' ' char(ymin) ')']);
xwp=round(vpa(solve(diff(yq(x),x,2)==0,x)),3);
ywp=round(vpa(yq(xwp)),3);
arrayfun(@(c) disp(['(xwp ywp) = (' char(xwp(c)) ' ' char(ywp(c)) ')']), [1:length(xwp)]);
xth=round(vpa(solve(yq(x)==q0*M0,x)),3);
yth=round(vpa(yq(xth)),3);
arrayfun(@(c) disp(['(xth yth) = (' char(xth(c)) ' ' char(yth(c)) ')']), [1:length(xth)]);
minstr=strcat(['Min: (x=$' num2str(double(xmin)) '$, y=$' num2str(double(ymin)) '$)']);
grid on % plot the rest
box on
xlabel('$x$')
ylabel('$y$')
title("Particular solution of $y'(x)=k\sqrt{y}(1-y/M)$");
plot(xmin, ymin, 'Marker', 'o', 'MarkerSize', 10,'DisplayName',minstr);
scatter(xwp, ywp,100,'Marker','x','DisplayName','Inflection points');
scatter(xth, yth,100,'Marker','+','DisplayName','Threshold points');
legend('location','best');
