preamble;
syms a b c d; syms N(t) P(t);
[a,b,c,d] = deal(11.5,3.8,4.1,1.2);

eq1=diff(N)==a*N(t)-b*N(t)*P(t);
eq2=diff(P)==-c*P(t)+d*N(t)*P(t);
inicond = [5.5,1.5];
% numerical solution
[eqs,vars]=reduceDifferentialOrder([eq1 eq2],[N(t),P(t)]);
[M,F]=massMatrixForm(eqs,vars);
f=M\F;
fh=odeFunction(f,vars);
tspan=[0 3];
opt=odeset('maxstep',0.1);
[t,fg]=ode23(fh,tspan,inicond,opt);
N=fg(:,1);
P=fg(:,2);

figure(1)
clf
subplot(2,1,1)
plot(t,N)
xlabel('$t$')
ylabel('$N(t)$')
title('Prey population')  
subplot(2,1,2)
plot(t,P)
xlabel('$t$')
ylabel('$P(t)$')
title('Predator population')  

figure(2)
clf
C=colormap;
title('Trajectory of Prey and Predators')  
h = animatedline('LineStyle','-','marker','.','color','r');
axis equal
xlim([0 10])
ylim([0 6])
grid on
box on
xlabel('$N(t)$')
ylabel('$P(t)$')
ht=text(0.1,0.1,['$t=',t(1),'$'],'fontsize',14);
for k=1:length(t)
    addpoints(h,fg(k,1),fg(k,2));
    hold on
    hp=plot(fg(k,1),fg(k,2),'bd','markersize',6);
    set(ht,'string',['$t=',num2str(t(k)),'$'])
    pause(0.05)
    set(hp,'visible','off')
end
hp=plot(N(k),P(k),'bd','markersize',6);
xlabel('$N(t)$')
ylabel('$P(t)$')
