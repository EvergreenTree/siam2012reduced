max_iter = 1000;
% [U_true, Lambda] = active_set();

mu = [.05,.25];
[U,Lambda] = active_set(mu,false);
EPS = .001;
for i = 2:max_iter
    [mu_max,fval] = fminsearch(@(mu)delta_true(mu,U,Lambda),mu(end,:));
    fprintf("Delta(u,X) = %f, Dimention of RB = %d\n", fval,i);
    mu = [mu;mu_max];
    [U_max,Lambda_max] = qp_constraint_poisson(mu_max,false);
    U = [U U_max];
    Lambda = [Lambda Lambda_max];
    if fval < EPS
        break
    end
end