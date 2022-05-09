preamble;
syms t;
r = 2;
x = r * (t - sin(t));
y = r * (1 - cos(t));
ds(t)=norm(diff([x,y]));
hf1=matlabFunction(ds);
hf2=matlabFunction(prod([x,y])*ds);
l = integral(hf1, 0, 2*pi)
I = integral(hf2, 0, 2*pi)
figure(1);
clf;
xlabel('$x$');
ylabel('$y$');
fplot(x,y,[0 2*pi]);
title('Cycloid given by $(x(t), y(t)) = (r (t- \sin t), r (1 - \cos t))$');