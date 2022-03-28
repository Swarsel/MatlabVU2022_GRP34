preamble
for j=[1:1:6]
    fname=strcat('System',num2str(j),'.mat');
    load(fname)
    if (rank(A) == rank([A b]))
        x=pinv(A)*b;
        if iszero(A*x-b)
            x
        end
    else
        disp(['Error in ',fname,': System not solvable'])
    end
end