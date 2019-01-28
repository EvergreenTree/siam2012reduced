function [u, lambda] = active_set(mu,flag_out)

% H = 200; %global param
global H;
h = 1/H;
xx = linspace(0,1,H+1)';
xxx = linspace(h,1-h,H-1)';
m0 = .15; 
if nargin < 1
    m1 = 1; m2 = .1;% parameters
else
    m1 = mu(1); m2=mu(2);
end
if nargin < 2
    flag_out = true;
end
fh = @(x) (- .2 * (sin(pi * x) - sin(3 * pi * x)) - .5 + m2 * ( x - .5));
ff = @(x) -1 + 0 * x;

% m02 = m0; m12 = m1; 
m01 = (m1 + m0);
DA = 1 / h * ...
    [m1*ones(H/2-1,1)*[-1 2 -1];
     [-m0 m01 -m1];
     m0*ones(H/2-1,1)*[-1 2 -1]];
A = (spdiags(DA,[-1 0 1],H-1,H-1));
% stiffness matrix (weighted)
A = blkdiag(1,A,1);
B = -speye(H+1);
F = h * ff(xxx);
F = [0;F;0];
u = A \ F;
hh = fh(xx);

lambda=-20*ones(H+1,1);
active=1;
I=speye(H+1);
max_iter = 1000;
for i=1:max_iter
    oldactive=active;
    active=lambda>=u-hh;
    lambda(~active)=0;
    u(active)=hh(active);
%     u(support)=(A)\(F-lambda);%solves (K+M)x=F
%     RHS=F+[zeros(size(A(:,~active))) -A(:,active)]*hh;
%     RHS=F+[zeros(size(A(:,~active))) -A(:,active)]*hh;
    RHS=F-A(:,active)*u(active);
    LHS=[A(:,~active) -I(:,active)]\RHS;
    inactive_length=sum(~active);
    u(~active)=LHS(1:inactive_length);
    lambda(active)=LHS(inactive_length+1:end);
    if oldactive==active
        break;
    end
end
% sprintf('Terminates at step %d\n',i)

% figure(1);
% plot(xx,fh(xx))% supporting plane
% 
% figure(2);
% plot(xx,u);%solution
if flag_out
%     figure(3);
%     hold off;
    hh = fh(xx);

    plot(xx,u);
    hold on;
    plot(xx,hh);
%     plot(xx,lambda);
end

end
% plot(xx,lambda)

% D = spdiags(ones(N-1,1)*[-1 2 -1],[-1 0 1],N-1,N-1);
% quadprog()