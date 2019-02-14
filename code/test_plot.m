suppress_warnings(); %suppress "Hessian not symmetric"
global H;
H=200;
h = 1/H;
xx = linspace(0,1,H+1)';
xxx = linspace(h,1-h,H-1)';
% compute RB
max_iter = 50;
[mu,U,Lambda,E1] = greedy_true_err(max_iter,false);
% % test RB linear system validity (active set passed, qp failed)
% figure(4);setfigure;
% test_dim3();
% % primal base
% figure(5);setfigure;
% plot(xxx*ones(1,max_iter+1),U);
% % dual base
% figure(6);
% plot(xxx*ones(1,max_iter+1),Lambda);
% % test distance between RB and some (non)snapshot solutions.
% figure(7);
% test_dist_snapshot_rand(U,Lambda);
% run training data
[E2,mu] = test_distance_RB(U,Lambda);
figure(3);hold off; semilogy(E1);hold on;
semilogy(E2,'o');legend(["training data","test data"]);setfigure;



