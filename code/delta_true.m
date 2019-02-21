    function [D] = delta_true(mu,U,Lambda)
%U = reduced space, mu = parameter
    global H
    [U_true,Lambda_true] = active_set(mu,false);
    [U_N,Lambda_N] = U_reduced(mu,U,Lambda);
%     D = norm(U_true-U_N);
    K = Stiffness(H-1);
    M = Mass(H-1);
    v = U_true-U_N;
    w = Lambda_true-Lambda_N; 
    D = v' * K * v + w' * ((K + M) \ w);
end