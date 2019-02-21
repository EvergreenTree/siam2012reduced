function [DD,mu] = test_distance_RB(U,Lambda,flag_true_err,flag_out)
if nargin < 3
    flag_true_err = true;
end
if nargin < 4
    flag_out = true;
end
max_iter = size(U,2) - 1;
N = 33;
mm = [.05,-.005];%min
MM = [.25,.5];%max
mm1 = linspace(mm(1),MM(1),N);
mm2 = linspace(mm(2),MM(2),N);
[M1,M2] = meshgrid(mm1,mm2);
DD = zeros(max_iter,1);
if flag_out
    figure(1);setfigure;
end
fprintf("testing max distance\n")
mu = [.15,.25];
for i = 2:max_iter+1
%     [mu_max,fval] = fmincon(@(mu)-delta_true(mu,U,Lambda),mu(end,:),[],[],[],[],mm,MM,[],opts1);
    if flag_true_err
        Deval = arrayfun(@(m1,m2)delta_true([m1,m2],U(:,1:(i-1)),Lambda(:,1:(i-1))),M1,M2);
    else
        Deval = arrayfun(@(m1,m2)delta_a_posteriori([m1,m2],U(:,1:(i-1)),Lambda(:,1:(i-1))),M1,M2);
    end
    fval = max(max(Deval));
    [j,k] = find(Deval == fval);
    mu_max = [mm1(k),mm2(j)];
    mu = [mu;mu_max];
    DD(i-1) = fval;
    fprintf("Delta(u,X) = %f, Dim_RB = %d, mu_max = %f, %f\n", fval,i,mu_max(1),mu_max(2));
%     pause();
end
figure(3);hold on;
semilogy(DD);setfigure;
end