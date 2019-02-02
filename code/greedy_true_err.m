max_iter = 15;
% [U_true, Lambda] = active_set();
mm = [.05,-.005];
MM = [.25,.5];
mu0 = [0.075, 0.4];
global H;
H=300;

mu = [.15,.25];
[U,Lambda] = active_set(mu,false);
EPS = .001;
opts1 = optimset('display','off');
N = 20;
mm1 = linspace(mm(1),MM(1),N);
mm2 = linspace(mm(2),MM(2),N);
[M1,M2] = meshgrid(mm1,mm2);
for i = 2:max_iter
%     [mu_max,fval] = fmincon(@(mu)-delta_true(mu,U,Lambda),mu(end,:),[],[],[],[],mm,MM,[],opts1);
    Deval = arrayfun(@(m1,m2)delta_true([m1,m2],U,Lambda),M1,M2);
    fval = max(max(Deval));
    [j,k] = find(Deval == fval);
    mu_max=[mm1(k),mm2(j)]
    subplot(4,4,i-1);
    surf(M1,M2,Deval);
%     hold off;
    fprintf("Delta(u,X) = %f, Dimention of RB = %d\n", fval,i);
%     pause();
    mu = [mu;mu_max];
    [U_max,Lambda_max] = active_set(mu_max,false);
    U = [U U_max];
    Lambda = [Lambda Lambda_max];
    if abs(fval) < EPS
        break;
    end
end
subplot(4,4,16);
plot(mu(:,1),mu(:,2),'o')


w = warning('query','last');
warning('off',w.identifier)


% testing the base
M1 = linspace(.05,.25,8)';
M2 = linspace(-.005,.5,8)';
mu0 = [0.075, 0.4];
[U0,Lambda0] = qp_constraint_poisson(mu0,true);
MU1 = [M1 ones(8,1)*mu0(2)];
MU2 = [ones(8,1)*mu0(1) M2];
for i = 1:8
    [U_N, Lambda_N] = U_reduced(MU1(i,:),U,Lambda);
    U_true = active_set(MU1(i,:),true);
    norm(U_true-U_N)
end


