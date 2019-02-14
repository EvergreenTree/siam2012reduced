function K = Stiffness(n)
    if nargin < 1
        global H;
        n=H;
%     H = 200;
    end
    h = 1/n; 
    DM = 1 / h * ones(n+1,1)*[-1 2 -1];
    K = (spdiags(DM,[-1 0 1],n,n));
end