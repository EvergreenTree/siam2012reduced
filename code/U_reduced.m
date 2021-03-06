function [U_N,Lambda_N,Alpha,Beta] = U_reduced(mu,U,Lambda,flag_out)
% min  .5*A*u-f
% s.t. - B >= - g
%     H = 200;
    if nargin < 4
        flag_out = false;
    end
    global H;
    h = 1/H;
    m0 = .15;%elasticity on [.5,1], fixed
    m1 = mu(1);%elasticity on [0,.5]
    m2 = mu(2);%slope of constraint h
    A = assemble_A(m0,m1);
    ff = @(x) -1 + 0 * x;
    xx = linspace(0,1,H+1)';
    xxx = linspace(h,1-h,H-1)';
%     f = [0;h * ff(xxx);0];
    f = h * ff(xxx);
    fh = @(x) (- .2 * (sin(pi * x) - sin(3 * pi * x)) - .5 + m2 * ( x - .5));
    hh = fh(xxx);
    B = speye(H-1);
%     F = [0;-h*ones(H-1,1);0];

    RA = U' * A * U;%reduced A %can be optimized during online phase
    Rf = U' * f;%reduced f
    RB = U' * B * Lambda;%reduced B
    Rg = Lambda' * hh;%reduced g
    
    [Alpha,~,~,~,Beta] = quadprog(RA,-Rf,-RB',-Rg,[],[],[],[],[],optimset('Display','off'));
    Beta = Beta.ineqlin;
%     Beta = Beta.lower;
    U_N = U * Alpha;
    Lambda_N = Lambda * Beta;
%     plot(xx,hh);

    if flag_out
        plot(xxx,U_N)
        hold on
        plot(xxx,hh)
        plot(xxx,Lambda_N)
    end
    
end