function [D] = delta_a_posteriori(mu,U,Lambda)
% a posteriori estimator without computing true solution
% U = reduced space, mu = parameter
%     [U_true,~] = active_set(mu,false);
    [U_N,Lambda_N] = U_reduced(mu,U,Lambda);
    % notations
    alpha = min([m0,m1]);%coercivity constant
    beta = 1;%inf-sup constant
    gamma = max([m0,m1]);%continuity constant
    K = Stiffness;
    M = Mass;
    
    %precompute
    fh = @(x) (- .2 * (sin(pi * x) - sin(3 * pi * x)) - .5 + m2 * ( x - .5));
    hh = fh(xx);
    v =  - assemble_A(mu) * U_N + Lambda_N;%residual r (for linear system)
    d_r = v' * K * v; %H^1_0
    v = subplus(-U_N - hh);%positive part of residual eta (for constraint)
    d_s1 = v' \ (K + M) * v; %H^(-1)
    d_s2 = Lambda_N \ (K + M) * v;
    c1 = (d_s1 * gamma / beta + d_r) / 2 / alpha;
    c2 = (d_s1 * d_r / beta + d_s2) / alpha;
    
    %compute a posteriori estimator
    D_u = c1+sqrt(c1^2+c2);
    D_lambda = (d_r + gamma * D_u) / beta;
    D = D_u + D_lambda;
end