% debugging RB solution dim = 3 %pass
global H
H=200;
xx = linspace(0,1,H+1)';
mu1 = [0.6, 0.4];
mu2 = [0.05, 0.35];
mu3 = [0.2, 0.2];
[U1,Lambda1] = qp_constraint_poisson(mu1,true);
[U2,Lambda2] = qp_constraint_poisson(mu2,true);
[U3,Lambda3] = qp_constraint_poisson(mu3,true);
U = [U1 U2 U3];
Lambda = [Lambda1 Lambda2 Lambda3];%2 bases
% plot(xx,U1)
% hold on 
% plot(xx,U2)
[U_N,Lambda_N,Alpha,Beta] = U_reduced(mu2,U,Lambda);
plot(xx,U_N,'x')

fprintf("dist(Snapshot,RedSp) = %f\n",delta_true(mu2,U,Lambda))
figure(2)

plot(xx,U_N-U2,'.')