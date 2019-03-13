function e=test_system_consistency()
%solve dirichlet problem u''+u=1 with dimension H+1 and H-1
n=1000000;
A=Mass(n-1);
B=Stiffness(n-1);
F=ones(n-1,1);

u=(A+B)\F;
u=[0;u;0];

A1=blkdiag(1,A,1);
B1=blkdiag(1,B,1);
F1=[0;ones(n-1,1);0];

u1=(A1+B1)\F1;

e=normH01(u-u1)/normH01(u);
end