% Entropy estimation of natural image patches
% via NN estimation
% Niru Maheswaranathan
% Sat Nov  3 18:57:19 2012

addpath('mex/');
thetas = linspace(0,2*pi,100);
N = round(logspace(1,5,20))';                   % size of neighbor set
patch_size = 16;                                 % patch size
k = 2;
Ak = (k*pi^(k/2))/gamma(k/2+1);
H = zeros(length(thetas), length(N));
runtimes = zeros(length(thetas),1);

% make gabor
[x y F1] = gabor('width',patch_size,'height',patch_size,'px',0.5,'py',0.5,'theta',0,'lambda',7,'Sigma',3);

for tIdx = 1:length(thetas)

    % second gabor
    [x y F2] = gabor('width',patch_size,'height',patch_size,'px',0.5,'py',0.5,'theta',thetas(tIdx),'lambda',7,'Sigma',3);

    tic;
    for i = 1:length(N)

        progressbar(i,length(N));
        n = N(i);                                   % number of neighbors

        % draw samples, project onto gabor functions
        samples = generate_samples(n,patch_size,'model','natural','num_images',min(round(0.1*n),50))*[F1(:) F2(:)];
        samples = samples + rand(size(samples));

        % compute minimum euclidean distance
        md = mindist(samples);

        % estimate entropy
        H(tIdx,i) = k*mean(log2(md)) + log2(n*Ak/k) - psi(1)/log(2);

    end
    runtimes(tIdx) = toc;

end

save('data/gabors.mat');
