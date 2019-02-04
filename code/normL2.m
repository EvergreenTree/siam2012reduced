function y = normL2(v)
    n = length(v);
    M = Mass(n-1);
    y = v' * M * v;
end