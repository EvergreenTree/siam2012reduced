function test_dim3(mu)
% debugging RB solution dim = 3 %pass
global H
H=200;
h = 1/H;
xx = linspace(0,1,H+1)';
xxx = linspace(h,1-h,H-1)';
mu1 = mu(1,:);
mu2 = mu(2,:);
mu3 = mu(3,:);
[U1,Lambda1] = active_set(mu1,true);
[U2,Lambda2] = active_set(mu2,true);
[U3,Lambda3] = active_set(mu3,true);
U = [U1 U2 U3];
Lambda = [Lambda1 Lambda2 Lambda3];%2 bases
% plot(xx,U1)
% hold on 
% plot(xx,U2)
[U_N,Lambda_N,Alpha,Beta] = U_reduced(mu1,U,Lambda);
plot(xxx,U_N,'x')

fprintf("dist(Snapshot,RedSp) = %f\n",delta_true(mu3,U,Lambda))
fprintf("Reduced primal = \n")
disp(Alpha)
fprintf("Reduced dual = \n")
disp(Beta)
% plot(xxx,U_N-U1,'.')
end