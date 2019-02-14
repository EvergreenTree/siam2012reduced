function A = assemble_A(m0,m1)
%     H = 200;
    global H;
    h = 1/H;
    m01 = (m1 + m0);
    DA = 1 / h * ...
        [m1*ones(H/2-1,1)*[-1 2 -1];
         [-m0 m01 -m1];
         m0*ones(H/2-1,1)*[-1 2 -1]];
    A = (spdiags(DA,[-1 0 1],H-1,H-1));
%     A = blkdiag(1,A,1);
end