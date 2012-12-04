% Entropy estimation of an ND Gaussian
% via NN estimation
% Niru Maheswaranathan
% Sat Nov  3 18:57:19 2012

addpath('mex/');
N = round(logspace(1,4,20))';                   % size of neighbor set
%sigmasq = 4;
k = 9;
Sigma = eye(k);

% Theoretical entropy estimate
H_theory = 0.5*log2((2*pi*exp(1))^k*det(Sigma));

% Nearest Neighbor estimate
H_nn = zeros(length(N),1);
Ak = (k*pi^(k/2))/gamma(k/2+1);

for i = 1:length(N)

    progressbar(i,length(N));
    n = N(i);                                   % number of neighbors
    samples = mvnrnd(zeros(1,k),Sigma,n);       % draw samples

    %distmat = dist(samples');
    %distmat = distmat + 1e2*eye(n);
    %md = min(distmat);

    md = mindist(samples);

    %distvec = pdist(samples);
    %mindist = zeros(n,1);
    %for j = 1:n
        %mindist(j) = min(distvec(randi(length(distvec),n-1,1)));
    %end

    H_nn(i) = k*mean(log2(md)) + log2(n*Ak/k) - psi(1)/log(2);

end

% Plots
fig(1); clf;
semilogx(N, H_nn, 'r*-', [N(1) N(end)], [H_theory H_theory], 'k--');
legend('NN estimate', 'True value');
title([num2str(k) 'D Gaussian']);
