function [U_N,Lambda_N] = U_reduced(mu,U,Lambda)
% min  .5*A*u-f
% s.t. - B >= - g
    h = 1/H;
    xx = linspace(0,1,H+1)';
%     xxx = linspace(h,1-h,N-1)';
    m0 = .15;%elasticity on [.5,1], fixed
    m1 = mu(1);%elasticity on [0,.5]
    m2 = mu(2);%slope of constraint
    A = assemble_A(m0,m1);
    fh = @(x) (- .2 * (sin(pi * x) - sin(3 * pi * x)) - .5 + m2 * ( x - .5));
    hh = fh(xx);
    B = -speye(H+1);

    RA = U' * A * U;%reduced A %can be optimized
    Rf = -sum(U) * h;%reduced f
    RB = U' * B * Lambda;%reduced B
    Rg = Lambda' * hh;%reduced g
    
    [Alpha,~,~,~,Beta] = quadprog(RA,-Rf,RB',Rg);
    Beta = Beta.lower;
    U_N = U * Alpha;
    Lambda_N = Lambda * Beta;
end