function [U_N,Lambda_N,Alpha,Beta] = U_reduced(mu,U,Lambda)
% min  .5*A*u-f
% s.t. - B >= - g
%     H = 200;
    global H;
    h = 1/H;
    m0 = .15;%elasticity on [.5,1], fixed
    m1 = mu(1);%elasticity on [0,.5]
    m2 = mu(2);%slope of constraint h
    A = assemble_A(m0,m1);
    ff = @(x) -1 + 0 * x;
    xx = linspace(0,1,H+1)';
    xxx = linspace(h,1-h,H-1)';
    f = [0;h * ff(xxx);0];
    fh = @(x) (- .2 * (sin(pi * x) - sin(3 * pi * x)) - .5 + m2 * ( x - .5));
    hh = fh(xx);
    B = -speye(H+1);
%     F = [0;-h*ones(H-1,1);0];

    RA = U' * A * U%reduced A %can be optimized during online phase
    Rf = U' * f;%reduced f
    RB = U' * B * Lambda;%reduced B
    Rg = Lambda' * hh;%reduced g
    
    [Alpha,~,~,~,Beta] = quadprog(RA,-Rf,RB',Rg,[],[],[],[],[],optimset('Display','off'));
    Beta = Beta.lower;
    U_N = -U * Alpha;
    Lambda_N = -Lambda * Beta;
    
end