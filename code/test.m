mu1 = [.05,.25];
mu2 = [0.075, 0.4];
[U1,Lambda1] = active_set(mu1,false);
[U2,Lambda2] = active_set(mu2,false);

U = [U1 U2];
Lambda = [Lambda1 Lambda2];
plot(xx,U1)
fh = @(x) (- .2 * (sin(pi * x) - sin(3 * pi * x)) - .5 + mu1(2) * ( x - .5));
hh = fh(xx);
plot(xx,Lambda1)
hold on 
plot(xx,Lambda2)

[U_N,Lambda_N] = U_reduced(mu1,U,Lambda);

plot(xx,Lambda_N)