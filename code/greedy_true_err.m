max_iter = 10;
% [U_true, Lambda] = active_set();
mm = [.05,-.005];
MM = [.25,.5];

mu = [.15,.25];
[U,Lambda] = active_set(mu,false);
EPS = .001;
opts1 = optimset('display','off');
for i = 2:max_iter
    [mu_max,fval] = fmincon(@(mu)-delta_true(mu,U,Lambda),mu(end,:),[],[],[],[],mm,MM,[],opts1);
    fprintf("Delta(u,X) = %f, Dimention of RB = %d\n", fval,i);
    mu = [mu;mu_max];
    [U_max,Lambda_max] = qp_constraint_poisson(mu_max,false);
    U = [U U_max];
    Lambda = [Lambda Lambda_max];
    if abs(fval) < EPS
        break;
    end
end
plot(mu(:,1),mu(:,2),'o')