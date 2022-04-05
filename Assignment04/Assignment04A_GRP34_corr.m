preamble;
A1=1;
A2=2;
phi1=pi/3;
phi2=-pi/2;
omega=1.5;
t=0:15/999:15;

harm = @(t,A,om,phi) (A * sin(om * t - phi));
Asum = @(A_1,A_2,phi_1,phi_2) (sqrt(A_1^2+A_2^2+2*A_1*A_2*cos(phi_2-phi_1)));
phisum = @(A_1,A_2,phi_1,phi_2) (atan2((A_1*sin(phi_1)+A_2*sin(phi_2)),(A_1*cos(phi_1) + A_2*cos(phi_2))));

AS = Asum(A1,A2,phi1,phi2)
phiS = phisum(A1,A2,phi1,phi2)

y1 = harm(t,A1,omega,phi1);
y2 = harm(t,A2,omega,phi2);
yS = harm(t,AS,omega,phiS);

y1p = plot(t,y1,'g:');
hold on;
y2p = plot(t,y2,'b:');
hold on;
y1p2 = plot(t,y1+y2,'r--');
hold on;
ySp = plot(t,yS,'k-.');
legend([y1p,y2p,y1p2,ySp],'$y_1(t)$','$y_2(t)$', '$y_1(t) + y_2(t)$','$y_S(t)$', 'location','southwest');
xlabel('$t$');
ylabel('$y_i(t)$');
title('$y_1(t),\; y_2(t),\; y_1(t)+y_2(t)$ and $y_S(t) = y_1(t)+y_2(t)$ superimposed');
