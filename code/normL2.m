function y = normL2(v)
    n = length(v);
    M = Mass(n);
    y = v' * M * v;
end