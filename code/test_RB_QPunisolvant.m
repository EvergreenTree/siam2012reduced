% mu(26,:)
% U(:,1:26),Lambda(:1:26)
% mu(27,:)
% 
% delta_true(mu(26,:),U(:,1:26),Lambda(:,1:26))
% delta_true(mu(27,:),U(:,1:26),Lambda(:,1:26))
% 
% 
% %good
% [U26,Lambda26] = active_set(mu(26,:),false);
% [U26_N,Lambda26_N,A,B] = U_reduced(mu(26,:),U(:,1:25),Lambda(:,1:25));
% K = Stiffness(H-1);
% M = Mass(H-1);
% v = U26-U26_N;
% w = Lambda26-Lambda26_N; 
% D = v' * K * v + w' * ((K + M) \ w)
% %bad
% [U27,Lambda27] = active_set(mu(27,:),false);
% [U27_N,Lambda27_N,A,B] = U_reduced(mu(27,:),U(:,1:26),Lambda(:,1:26));
% K = Stiffness(H-1);
% M = Mass(H-1);
% v = U27-U27_N;
% w = Lambda27-Lambda27_N; 
% D = v' * K * v + w' * ((K + M) \ w)
% %ugly
% [U1_N,Lambda1_N,A1,B1] = U_reduced(mu(27,:),U(:,1:25),Lambda(:,1:25));
% v = U27-U1_N;
% w = Lambda27-Lambda1_N; 
% D1 = v' * K * v + w' * ((K + M) \ w)
% 
% 
% U2_N=U(:,1:26)*[A1;0];
% Lambda2_N=Lambda(:,1:26)*[B1;0];
% v = U_true-U2_N;
% w = Lambda_true-Lambda2_N; 
% D2 = v' * K * v + w' * ((K + M) \ w)
% 
% mm = [.05,-.005];
% MM = [.25,.5];
% N = 32;
% mm1 = linspace(mm(1),MM(1),N);
% mm2 = linspace(mm(2),MM(2),N);
% [M1,M2] = meshgrid(mm1,mm2);
% 
% Deval = arrayfun(@(m1,m2)delta_true([m1,m2],U(:,1:25),Lambda(:,1:25)),M1,M2);
% figure(1);hold off;
% surf(M1,M2,Deval);
% xlabel("\mu_1")
% ylabel("\mu_2")
% fval = max(max(Deval));
% [j,k] = find(Deval == fval);
% mu_max=[mm1(k),mm2(j)];
% pause;
% Deval2 = arrayfun(@(m1,m2)delta_true([m1,m2],U(:,1:26),Lambda(:,1:26)),M1,M2);
% figure(1);hold on;
% surf(M1,M2,Deval2);
% xlabel("\mu_1")
% ylabel("\mu_2")
% fval2 = max(max(Deval2));
% [j,k] = find(Deval2 == fval2);
% mu_max2=[mm1(k),mm2(j)];
% 
% delta_true(mu_max2,U(:,1:26),Lambda(:,1:26))
% 
% [U27,Lambda27] = active_set(mu_max2,false);
% [U2_N,Lambda2_N,A2,B2] = U_reduced(mu_max2,U(:,1:26),Lambda(:,1:26));
% v = U27-U2_N;
% w = Lambda27-Lambda2_N; 
% D2 = v' * K * v + w' * ((K + M) \ w)
% 
% 
% %%%
% [U26,Lambda26] = active_set(mu(22,:),false);
% [U26_N,Lambda26_N,A,B] = U_reduced(mu(22,:),U(:,1:21),Lambda(:,1:21));
% K = Stiffness(H-1);
% M = Mass(H-1);
% v = U26-U26_N;
% w = Lambda26-Lambda26_N; 
% D = v' * K * v + w' * ((K + M) \ w)
% 
% [U26,Lambda26] = active_set(mu(23,:),false);
% [U26_N,Lambda26_N,A,B] = U_reduced(mu(23,:),U(:,1:22),Lambda(:,1:22));
% K = Stiffness(H-1);
% M = Mass(H-1);
% v = U26-U26_N;
% w = Lambda26-Lambda26_N; 
% D = v' * K * v + w' * ((K + M) \ w)
% 
% delta_true(mu(22,:),U(:,1:22),Lambda(:,1:22))
% 
%     [U_true,Lambda_true] = active_set(mu(22,:),false);
%     [U_N,Lambda_N] = U_reduced(mu(22,:),U(:,1:22),Lambda(:,1:22));
% %     D = norm(U_true-U_N);
%     K = Stiffness(H-1);
%     M = Mass(H-1);
%     v = U_true-U_N;
%     w = Lambda_true-Lambda_N; 
%     D = v' * K * v + w' * ((K + M) \ w);
% 
%     
    
max_iter = 25;
[mu,U,Lambda,E1] = greedy_true_err(max_iter,false);
[U_true,Lambda_true] = active_set(mu(21,:),false);
[U_N,Lambda_N,Alpha,Beta] = U_reduced(mu(21,:),U(:,1:22),Lambda(:,1:22));
normH01(U_true-U_N)

