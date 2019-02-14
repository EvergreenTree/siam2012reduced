suppress_warnings(); %suppress "Hessian not symmetric"
global H;
H=200;
h = 1/H;
xx = linspace(0,1,H+1)';
xxx = linspace(h,1-h,H-1)';
% compute RB
max_iter = 20;
[mu,U,Lambda] = greedy_a_posteriori(max_iter,true,4,5);
% test RB linear system validity (active set passed, qp failed)
figure(4);setfigure;
test_dim3();
% primal base
figure(5);setfigure;
plot(xxx*ones(1,max_iter+1),U);
% dual base
figure(6);
plot(xxx*ones(1,max_iter+1),Lambda);
% test distance between RB and some (non)snapshot solutions.
figure(7)
test_dist_snapshot(U,Lambda);