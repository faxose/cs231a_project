% Entropy estimation of an ND Gaussian
% via NN estimation
% Niru Maheswaranathan
% Sat Nov  3 18:57:19 2012

addpath('mex/');
N = round(logspace(1,4,20))';                   % size of neighbor set
%sigmasq = 4;
ks = 2:9;

% Theoretical entropy estimate
H_theory = 0.5*log2((2*pi*exp(1)).^ks);

% Nearest Neighbor estimate
H_nn = zeros(length(N),length(ks));

for i = 1:length(N)

    progressbar(i,length(N));
    n = N(i);                                   % number of neighbors
    samples = mvnrnd(zeros(1,ks(end)),eye(ks(end)),n);       % draw samples

    %distmat = dist(samples');
    %distmat = distmat + 1e2*eye(n);
    %md = min(distmat);

    for j = 1:length(ks)
        k = ks(j);
        Ak = (k*pi^(k/2))/gamma(k/2+1);
        md = mindist(samples(:,1:k));
        H_nn(i,j) = k*mean(log2(md)) + log2(n*Ak/k) - psi(1)/log(2);
    end

end

% Plots
fig(1); clf; hold on;
colors = 'rgb'; values = [3 5 8];
for i = 1:3
    semilogx(N, H_nn(:,values(i)), '*-', 'Color', colors(i));
    semilogx([N(1) N(end)], [H_theory(values(i)) H_theory(values(i))], '--', 'Color', colors(i));
    %legend('NN estimate', 'True value');
    %title([num2str(k) 'D Gaussian']);
end
