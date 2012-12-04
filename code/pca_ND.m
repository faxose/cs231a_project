% Entropy estimation of natural image patches
% via NN estimation
% Niru Maheswaranathan
% Sat Nov  3 18:57:19 2012

for k = 1:9

    clearvars -except k;
    addpath('mex/');
    N = round(logspace(1,5,20))';                   % size of neighbor set
    patch_size = 3;                                 % patch size

    % Nearest Neighbor estimate
    H_nn = zeros(length(N),1);
    Ak = (k*pi^(k/2))/gamma(k/2+1);

    % PCA
    X = generate_samples(1e4,patch_size,'model','natural','num_images',50);
    coeff = princomp(X);

    tic;
    for i = 1:length(N)

        progressbar(i,length(N));
        n = N(i);                                   % number of neighbors

        % draw samples
        samples = generate_samples(n,patch_size,'model','natural','num_images',min(round(0.1*n),50))*coeff(:,1:k);
        samples = samples + rand(size(samples));

        % compute minimum euclidean distance
        md = mindist(samples);

        % estimate entropy
        H_nn(i) = k*mean(log2(md)) + log2(n*Ak/k) - psi(1)/log(2);

    end
    toc;

    % Plots
    fig(1); clf;
    semilogx(N, H_nn/(patch_size^2), 'r*-');
    ylabel('Entropy (bits/pixel)');
    xlabel('# of Samples');
    makepretty;
    save(['data/pca_3x3_' num2str(k) '.mat']);

end
