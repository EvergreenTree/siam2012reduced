function y = normH01(v)
    n = length(v);
    K = Stiffness(n);
    y = v' * K * v;
end