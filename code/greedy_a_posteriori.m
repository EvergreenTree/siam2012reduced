
%suppress warnings
% w = warning('query','last');
% warning('off',w.identifier)
w2 = struct;
w2.identifier= 'optim:quadprog:HessianNotSym';
w2.state= 'on';

max_iter = 9;
% [U_true, Lambda] = active_set();
mm = [.05,-.005];
MM = [.25,.5];
mu0 = [0.075, 0.4];
global H;
H=200;

mu = [.15,.25];
[U,Lambda] = active_set(mu,false);
EPS = 1e-6;
opts1 = optimset('display','off');
N = 20;
mm1 = linspace(mm(1),MM(1),N);
mm2 = linspace(mm(2),MM(2),N);
[M1,M2] = meshgrid(mm1,mm2);
DD = zeros(max_iter-1);
figure(1);
for i = 2:max_iter+1
%     [mu_max,fval] = fmincon(@(mu)-delta_true(mu,U,Lambda),mu(end,:),[],[],[],[],mm,MM,[],opts1);
    Deval = arrayfun(@(m1,m2)delta_a_posteriori([m1,m2],U,Lambda),M1,M2);
    fval = max(max(Deval));
    DD(i-1) = fval;
    [j,k] = find(Deval == fval);
    mu_max=[mm1(k),mm2(j)];
    subplot(3,3,i-1);%modify it according to max_iter
    surf(M1,M2,Deval);
%     hold off;
    fprintf("Delta(u,X) = %f, Dim_RB = %d, mu_max = %f, %f\n", fval,i,mm1(k),mm2(j));
%     pause();
    mu = [mu;mu_max];
    [U_max,Lambda_max] = qp_constraint_poisson(mu_max,false);
    U = [U U_max];
    Lambda = [Lambda Lambda_max];
    if abs(fval) < EPS
        break;
    end
end

figure(2);
plot(mu(:,1),mu(:,2),'o')
xlabel("\mu_1")
ylabel("\mu_2")
xlim([.05,.25])
ylim([-.05,.5])
title('Greedy Algorithm (a posteriori estimate)')

figure(3);
semilogy(DD)
xlabel("iteration")
ylabel('sup_\mu D_{a posteriori}(\mu,RB)')
title('evolution of a posteriori estimate')


