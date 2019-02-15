function test_dist_snapshot_rand(U,Lambda)
% testing the base
M1 = linspace(.05,.25,8)';
M1 = M1(1)+(M1(2)-M1(1))*rand(8,1);
M2 = linspace(-.005,.5,8)';
% mu0 = [0.075, 0.4];
mu0 = [0.0500   -0.0050];
[U0, Lambda0] = active_set(mu0,false);
[U_N, Lambda_N,Alpha,Beta] = U_reduced(mu0,U,Lambda);
Alpha
fprintf("snapshot: D(u,RB)/norm(u) = %f\n",normL2(U0-U_N));
MU1 = [M1 ones(8,1)*mu0(2)];
% MU2 = [ones(8,1)*mu0(1) M2];
for i = 1:8
    subplot(3,3,i)
    [U_N, Lambda_N] = U_reduced(MU1(i,:),U,Lambda,true);
    U_true = active_set(MU1(i,:),true);
    fprintf("non-snapshot: D(u,RB)/norm(u) = %f\n",normL2(U_true-U_N));
end
end