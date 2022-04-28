preamble
syms x y;
f(x,y)=x^4-x^2-y^3+y^2+2;
J=jacobian(f);
H=jacobian(J);
sol=solve(J,x,y);
[solx, soly]= deal(double(sol.x),double(sol.y));

for j=1:length(solx)
    solH=subs(H,{x,y},{solx(j),soly(j)});
    solz(j)=double(f(solx(j),soly(j)));
    lambdas=eig(solH);
    if all(lambdas>0)
        character(j)="min";
    elseif all(lambdas<0)
        character(j)="max";
    else
        character(j)="sp";
    end
end

fhandle=matlabFunction(f);
[gridx,gridy]=meshgrid(linspace(-1,1,101),linspace(-0.7,1.3,101));
gridz=fhandle(gridx,gridy);

figure(1)
clf
surf(gridx,gridy,gridz);
xlabel('$x$');
ylabel('$y$');
zlabel('$z$');
colorbar;
title('Surface plot of $f(x,y)=x^4-x^2-y^3+y^2+2$');

figure(2)
clf
contour(gridx,gridy,gridz,[solz,linspace(min(gridz(:)),max(gridz(:)),21)]);
xlabel('$x$');
ylabel('$y$');
zlabel('$z$');
colorbar;
hold on;
scatter(solx,soly)
text(solx+0.05,soly,character)
axis equal
title('Contour plot of $f(x,y)=x^4-x^2-y^3+y^2+2$');