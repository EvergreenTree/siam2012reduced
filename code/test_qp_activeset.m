function y=test_qp_activeset(mu)
% error between two solvers
u1=active_set(mu);
u2=qp_constraint_poisson(mu);
y=normH01(u1-u2)/normH01(u1);
end