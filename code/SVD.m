H=200;
N1 = 10; N2 = 10;
M1 = linspace(.1,2,N1);
M2 = linspace(.1,2,N2);

U = zeros(N1,N2,H+1);
for i = 1:N1
    for j = 1:N2
        U(i,j,:) = active_set(M1(i),M2(j),true); 
    end
end

UU=zeros(N1*N2,H+1);
for i = 1:N1
    for j = 1:N2
        UU(N1*(i-1)+j,:) = active_set(M1(i),M2(j),true);
    end
end

% K = zeros(N1*N2,N1*N2);
% for i = 1:N1*N2
%     for j = 1:N1*N2
%         K(i,j) = dot(UU(i,:),UU(j,:)); 
%     end
% end

[KU,KS,KV] = svd(UU*UU');

[KU,KD] = schur(UU*UU');
d_red = 7;
KU = KU(end-d_red,end,:);%major eigs
P = KU*UU;% bases [e_i]
m0 = 1;m1 = .15;
A = assemble_A(m0,m1)



xx = linspace(0,1,H+1)';
plot(xx,squeeze(U(1,1,:)))

U