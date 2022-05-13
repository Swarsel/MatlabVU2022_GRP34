preamble
%
syms y(x) % unknown symbolic function
Dy=diff(y,x,1); % first derivative
D2y=diff(y,x,2); % second derivative
D3y=diff(y,x,3); % third derivative

syms k q M % constant coefficients
syms C1 C2 C3 % integrations constant

eqstr="y'- k * sqrt(y) * (1 - y/M)"; % ay'+by=0
k0=0.05; M0=10; const=[k0 M0]; % set constants
inicond=[y(0)==5]; % initial condition
rg=[0 1]; % plot range
titstr="$y'- 0.05 \sqrt{y} (1- y/10) = 0,\ y(0)=5$";

lastwarn('')
figure(1)
clf
mystr="Equation: $"+titstr+"$";
title(mystr,'fontsize',18)
box on
xlabel('$t$')
ylabel('$y(t)$')
%
eqs=strrep(eqstr,"y'''","D3y");eqs=strrep(eqs,"y''","D2y");eqs=strrep(eqs,"y'","Dy");
eq=eval(eqs);
disp(['Equation : ',char(eqstr),'=0']);
ysolgen(x)=dsolve(eq==0, 'x');
disp(['General solution: y(x)=',char(ysolgen(x))]);

% check solution by substituting ysolgen back into equation
s=simplify(subs(eq,y,ysolgen))
if s==0,disp('General solution is correct'),end
% particular solution
ysolpar(x)=simplify(dsolve(eq==0,inicond));
disp(['Particular solution: y(x)=',char(ysolpar(x))]);
s=simplify(subs(eq,y,ysolpar));
if s==0,disp('Particular solution is correct'),end
% substitute constants, if any
if ~isempty(const)
    v=symvar(eq);
    eqsubs=subs(eq,v(2:end),const);
    for j=2:length(v)
        eqstr=strrep(eqstr,char(v(j)),num2str(const(j-1)));
    end
    disp('Substitute constants')
    disp(['Equation: ',char(eqstr),'=0']);
    ysolpar(x)=simplify(dsolve(eqsubs,inicond));
    disp(['Particular solution: y(t)=',char(ysolpar(x))]);
    s=simplify(subs(eqsubs,y,ysolpar));
end
% plot solution
fplot(real(ysolpar),rg); % 
title(mystr,'fontsize',20)
legend(['$y(t)=',latex(ysolpar),'$'],'fontsize',20,'location','best')
box on
xlabel('$t$')
ylabel('$y(t)$')
grid on
drawnow
str=input('Type CR to continue or 0 to stop','s');
