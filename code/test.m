%output fig: adjust mu1 or m2
M1 = linspace(.05,.25,8)';
M2 = linspace(-.005,.5,8)';
mu0 = [0.075, 0.4];
[U0,Lambda0] = qp_constraint_poisson(mu0,true);
MU1 = [M1 ones(8,1)*mu0(2)];
MU2 = [ones(8,1)*mu0(1) M2];

hold on;
for i = 1:8
    active_set(MU1(i,:),true);
end

hold on;
for i = 1:8
    active_set(MU2(i,:),true);
end

%$ debugging RB solution dim = 2 %pass
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


%test dim = 1 %pass
mu = [0.01, 0.35];
% mu = [0.4, 0.2];
[U,Lambda] = active_set(mu,false);
plot(xx,U)
[U_N,Lambda_N,Alpha,Beta] = U_reduced(mu,U,Lambda);
hold on;
plot(xx,U_N)


%computing time for both QP methods
t1 = zeros(20,1);t2 = zeros(20,1);

global H;
for i = 1:100
    H = 10*i;
    tic;
    active_set(mu0,false);
    t1(i) = toc;
    tic;
    qp_constraint_poisson(mu0,false);
    t2(i) = toc;
end
plot(10:10:1000,t1)
hold on 
plot(10:10:1000,t2)
legend('Active set','Interior Point')
xlabel('H')
ylabel('time')




hold on;
for i = 1:8
    [U_N,Lambda_N,Alpha,Beta] = U_reduced(MU2(i,:),U,Lambda);
    Beta
end

