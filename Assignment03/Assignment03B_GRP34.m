preamble
delta=1E-10;
X=[0:0.5:10];
N=[0:0.5:4];
T=table(X','VariableNames',{'x='});
for alpha=N
    k=0;
    J=((X./2).^alpha)./(gamma(1)*gamma(1+alpha)); %first term in the sum
    k=k+1; %execute second iteration because Jk must exist before loop
    Jk=((X./2).^(2*k+alpha)).*((-1)^k/(gamma(k+1)*gamma(k+1+alpha)));
    while norm(Jk, "inf")>=delta
        J=J+Jk;
        k=k+1;
        Jk=((X./2).^(2*k+alpha)).*((-1)^k/(gamma(k+1)*gamma(k+1+alpha)));
    end
    Tj=table(J','VariableNames',{strcat('alpha=',num2str(alpha))});
    T=[T Tj];
end
T
