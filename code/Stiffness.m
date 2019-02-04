function K = Stiffness
    global H
%     H = 200;
    h = 1/H;
    DM = 1 / h * ones(H+1,1)*[-1 2 -1];
    K = (spdiags(DM,[-1 0 1],H+1,H+1));
end