function [u,lambda] = U_reduced_fast(mu,U,Lambda,A0,A1,hh0,hh1,f,flag_out)
    if nargin < 4
        flag_out = false;
    end
    
    m1 = mu(1);%elasticity on [0,.5]
    m2 = mu(2);%slope of constraint h
    A = A0 + m1 * A1;
    hh = hh0 + m2 * hh1;
    
    %solve RB system
    RA = U' * A * U;%reduced A %can be optimized during online phase
    Rf = U' * f;%reduced f
    RB = U' * B * Lambda;%reduced B
    Rg = Lambda' * hh;%reduced g
    
%     [Alpha,~,~,~,Beta] = quadprog(RA,-Rf,RB',-Rg,[],[],[],[],[],optimset('Display','off'));
%     Beta = Beta.ineqlin;
%     Beta = Beta.lower;

    [Alpha,~,~,~,Beta] = active_set_ineq(RA,-Rf,RB',-Rg,hh);

    U_N = U * Alpha;
    Lambda_N = Lambda * Beta;
%     plot(xx,hh);

    if flag_out
        plot(xx,U_N)
        hold on
        plot(xx,hh)
        plot(xx,Lambda_N)
    end
end