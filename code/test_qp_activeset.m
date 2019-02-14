% error between two solvers
u1=active_set;
u2=qp_constraint_poisson;
norm(u1-u2)/norm(u1)