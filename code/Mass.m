function M = Mass(n)
%     H = 200;
    if nargin < 1
        global H;
        n = H;
    end
    h = 1/n;
    DM = h * ones(n+1,1)*[1/6 1 1/6];
    M = (spdiags(DM,[-1 0 1],n,n));
end