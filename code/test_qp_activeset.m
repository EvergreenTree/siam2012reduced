function y=test_qp_activeset(mu)
% error between two solvers
u1=active_set(mu);
u2=qp_constraint_poisson(mu);
y=norm(u1-u2)/norm(u1);
end