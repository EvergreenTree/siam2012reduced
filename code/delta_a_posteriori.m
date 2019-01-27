function [D] = delta_a_posteriori(mu,U,Lambda)
%U = reduced space, mu = parameter
%     [U_true,~] = active_set(mu,false);
    [U_N,Lambda_N] = U_reduced(mu,U,Lambda);
    alpha = min([m0,m1]);
    beta = 1;
    gamma = max([m0,m1]);
    v = f - assemble_A(mu) * U_N + *Lambda_N;
    d_r = v' * assemble_A([1 1])  v;
    d_s1 = subplus(-U_N - hh);
    d_s2 = 
    c1 = (d_s1 * gamma / beta + d_r) / 2 / alpha;
    c2 = (d_s1 * d_r / beta + d_s2) / alpha;
    D_u = c1+sqrt(c1^2+c2);
    D_lambda = (d_r + gamma * D_u) / beta;
    D = D_u + D_lambda;
end