%output fig: adjust mu1 or m2
M1 = linspace(.05,.25,8)';
M2 = linspace(-.005,.5,8)';
mu0 = [0.075, 0.4];
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

%debugging RB solution
global H
H=200
mu1 = [0.075, 0.4];
mu2 = [0.1, 0.3];
xx = linspace(0,1,H+1)';
[U1,Lambda1] = active_set(mu1,false);
[U2,Lambda2] = active_set(mu2,false);
U = [U1 U2];
Lambda = [Lambda1 Lambda2];%2 bases
plot(xx,U1)
hold on 
plot(xx,U2)

mu3 = [0.01, 0.35];
[U3,Lambda3] = active_set(mu3,false);
plot(xx,U3)
[U_N,Lambda_N,Alpha,Beta] = U_reduced(mu3,U,Lambda);
hold on;
plot(xx,U_N)

plot(xx,Lambda1)
hold on 
plot(xx,Lambda2)

