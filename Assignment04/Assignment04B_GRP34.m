preamble
mypol=@(x,c) (sum(c(:)'.*x(:).^[length(c)-1:-1:0], 2));
x=[0:0.5:5];
c=[0.1,-1.5,8.5,-22.5,27.5,-12];
p1=mypol(x,c);
p2=mypol(x,c');
p3=mypol(x',c);
p4=mypol(x',c');
array2table([x' round([p1 p2 p3 p4],4)],'VariableNames',{'x' 'p1' 'p2' 'p3' 'p4'})