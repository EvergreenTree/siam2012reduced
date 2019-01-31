function M = Mass
    H = 200;
    h = 1/H;
    DM = h * ones(H+1,1)*[1/6 1 1/6];
    M = (spdiags(DM,[-1 0 1],H+1,H+1));
end