global H;
h = 1/H;
m0 = .15;%elasticity on [.5,1], fixed
m1 = mu(1);%elasticity on [0,.5]
m2 = mu(2);%slope of constraint h
A0 = assemble_A(m0,0);
A1 = assemble_A(0,1);


ff = @(x) -1 + 0 * x;
xxx = linspace(h,1-h,H-1)';
f = [0;h * ff(xxx);0];

xx = linspace(0,1,H+1)';
fh0 = @(x) - .2 * (sin(pi * x) - sin(3 * pi * x))- .5;
hh0 = fh0(xx);
fh1 = @(x)  ( x - .5);
hh1 = fh1(xx);

[u,lambda] = U_reduced_fast(mu,U,Lambda,A0,A1,hh0,hh1,f,false);




