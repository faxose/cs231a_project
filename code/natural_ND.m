% Entropy estimation of natural image patches
% via NN estimation
% Niru Maheswaranathan
% Sat Nov  3 18:57:19 2012

addpath('mex/');
N = round(logspace(1,5,20))';                   % size of neighbor set
k = 1;

% Nearest Neighbor estimate
H_nn = zeros(length(N),1);
Ak = (k*pi^(k/2))/gamma(k/2+1);

tic;
for i = 1:length(N)

    progressbar(i,length(N));
    n = N(i);                                   % number of neighbors

    % draw samples
    samples = generate_samples(n,k,'model','natural','num_images',min(round(0.1*n),50));% + rand(n,k^2);
    samples = samples + rand(size(samples));

    % compute minimum euclidean distance
    md = mindist(samples);

    % estimate entropy
    H_nn(i) = k*mean(log2(md)) + log2(n*Ak/k) - psi(1)/log(2);

end
toc;

% Plots
fig(1); clf;
semilogx(N, H_nn/(k^2), 'r*-');
ylabel('Entropy (bits/pixel)');
xlabel('# of Samples');
makepretty;
