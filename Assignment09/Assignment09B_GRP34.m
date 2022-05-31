preamble;
opt=odeset('AbsTol',1E-8);
syms y(t);
Dy=diff(y,t); D2y=diff(y,t,2);
y0=[2; 0];
solver={@ode23, @ode45, @ode23s};
close all;
figure('Name','Solution of van der Pol`s equation');
Vnames={'mu','solver','elapsed time','timesteps'};
T=array2table(zeros(1,4),'VariableNames',Vnames);
p=1;
for mu=[30 100 300]
    subplot(3,1,p);
    hold on;
    tspan=[0 10*mu];
    for i=1:3
        eq=D2y-mu*(1-y^2)*Dy+y;
        [eqs,vars]=reduceDifferentialOrder(eq,y(t));
        [M,F]=massMatrixForm(eqs,vars);
        f=M\F;
        fh=odeFunction(f,vars);
        tic;
        sol=solver{i}(fh,tspan,y0,opt);
        etime=toc;
        xs=sol.x;
        ys=sol.y(1,:);
        h=plot(xs,ys,'displayname', sol.solver);
        A={mu sol.solver etime length(sol.x)};
        T1=cell2table(A,'VariableNames',Vnames);
        T=[T;T1];
    end
    box on
    grid on
    xlabel('$t$');
    ylabel('$y(t)$');
    drawnow;
    subtitle(['Solution of $y\prime\prime-\mu(1-y^2)y\prime+y=0$ for $\mu=$' num2str(mu)]);
    legend();
    p=p+1;
end
T([1],:)=[];
T
