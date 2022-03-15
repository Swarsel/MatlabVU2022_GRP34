preamble
R=rand(5,8)
R([1 2 4],[3 5 7])
R(2:2:size(R,1),2:2:size(R,2))
R(R(:,1)>0.5,:)
R(:,R(size(R, 1),:)<0.4)
S=R