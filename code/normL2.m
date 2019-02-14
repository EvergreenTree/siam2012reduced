function y = normL2(v)
    n = length(v);
    K = Stiffness(n);
    y = v' * K * v;
end