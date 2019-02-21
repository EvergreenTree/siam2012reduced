function [mu, U,Lambda,DD] = greedy_a_posteriori(max_iter,flag_out,m,n)
suppress_warnings();
if nargin < 2
    flag_out = false;
end
if nargin < 3
    m = ceil(sqrt(max_iter));
    n = ceil(max_iter/m);
end
% max_iter = 20;
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
N = 17;
mm1 = linspace(mm(1),MM(1),N);
mm2 = linspace(mm(2),MM(2),N);
[M1,M2] = meshgrid(mm1,mm2);
DD = zeros(max_iter,1);
if flag_out
    figure(1);setfigure;
end
fprintf("computing RB\n ")
for i = 2:max_iter+1
%     [mu_max,fval] = fmincon(@(mu)-delta_true(mu,U,Lambda),mu(end,:),[],[],[],[],mm,MM,[],opts1);
    Deval =  arrayfun(@(m1,m2)delta_a_posteriori([m1,m2],U,Lambda),M1,M2);
    fval = max(max(Deval));
    DD(i-1) = fval;
    [j,k] = find(Deval == fval);
    mu_max=[mm1(k),mm2(j)];
    if flag_out
        subplot(m,n,i-1);%modify it according to max_iter
        surf(M1,M2,Deval);
%     hold off;
    end
    fprintf("Delta(u,X) = %f, Dim_RB = %d, mu_max = %f, %f\n", fval,i,mm1(k),mm2(j));
%     pause();
    mu = [mu;mu_max];
    [U_max,Lambda_max] = active_set(mu_max,false);
    U = [U U_max];
    Lambda = [Lambda Lambda_max];
    if abs(fval) < EPS
        break;
    end
end
if flag_out
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
end
end

