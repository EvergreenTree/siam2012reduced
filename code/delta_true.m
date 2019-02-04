function [D] = delta_true(mu,U,Lambda)
%U = reduced space, mu = parameter
    [U_true,~] = active_set(mu,false);
    [U_N,~] = U_reduced(mu,U,Lambda);
%     D = norm(U_true-U_N);
    M = Mass;
    v = U_true-U_N;
    D = v' * M * v;
end