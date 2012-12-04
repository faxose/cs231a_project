% Entropy estimation of a 1D non-Gaussian distribution
% via NN and KD estimates
% Niru Maheswaranathan
% Sat Nov  3 18:57:19 2012

addpath('mex/');
N = round(logspace(1,5,20))';                   % size of neighbor set
num_images = 5;                                 % # of images to use to estimate pdf

% Kernel Density estimate
H_kde = zeros(length(N),1);

% Nearest Neighbor estimate
H_nn = zeros(length(N),1);

% get data
%data = [];
%for i = 1:num_images
    %img = loadimage(randi(50));
    %data = [data; img(:) + rand(size(img(:)))];        % dither
%end

for i = 1:length(N)

    progressbar(i,length(N));
    n = N(i);                                   % number of neighbors

    %indices = randi(length(data),n,1);          % pick n random indices
    %samples = col(data(indices));               % draw n samples from data
    samples = laprnd(n,1);

    %distmex = build(n,[samples zeros(n,1)]);    % NN distances
    %distmex = distmex + distmex' + 1e3*eye(n);  % fix distance matrix
    %mindist = min(distmex);                     % get minimum distances
    %mindist(mindist == 0) = [];                 % kill repeats
    md = mindist(samples);
    H_nn(i) = mean(log2(md)) + log2(2*n) - psi(1)/log(2);

    H_kde(i) = entropy(samples);                 % estimate entropy from PDF

end

% Plots
fig(1); clf;
subplot(211); imgsc(img);
subplot(212); plot(x,p,'k-'); makepretty;
xlabel('x'); ylabel('p(x)');

fig(2); clf;
semilogx(N, H_nn, 'r*-', N, H_kde, 'c*-');
legend('NN estimate', 'KD estimate');
