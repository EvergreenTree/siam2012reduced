
%suppress warnings
% w2 = warning('query','last');
w2 = struct;
w2.identifier= 'optim:quadprog:HessianNotSym';
w2.state= 'on';
warning('off',w2.identifier)