function [u, lambda] = qp_constraint_poisson(mu,flag_out)
    if nargin < 1 
        mu = [.1,.1];
    end
    if nargin < 2
        flag_out = true;
    end
    %parameters
    m1 = mu(1);%elasticity on [0,.5]
    m2 = mu(2);%slope of constraint
    m0 = .15;%fixed
    global H;
    h = 1/H;
    A = assemble_A(m0,m1);
    ff = @(x) -1 + 0 * x;
    xx = linspace(0,1,H+1)';
    xxx = linspace(h,1-h,H-1)';
    f = [0;h * ff(xxx);0];
    fh = @(x) (- .2 * (sin(pi * x) - sin(3 * pi * x)) - .5 + m2 * ( x - .5));
    hh = fh(xx);
%     [u,~,~,~,lambda] = quadprog(A,-f,[],[],[],[],hh,[],[],optimset('Display','off')); %b -> lower bound
%     lambda = lambda.lower;
    B = -speye(H+1);
    [u,~,~,~,lambda] = quadprog(A,-f,B',-hh,[],[],[],[],[],optimset('Display','off')); %b -> lower bound
    lambda = lambda.ineqlin;
    
    if flag_out
        plot(xx,u)
        hold on
        plot(xx,hh)
        plot(xx,lambda)
    end
end