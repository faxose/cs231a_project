% Entropy estimation of a 1D non-Gaussian distribution
% via NN and KD estimates
% Niru Maheswaranathan
% Sat Nov  3 18:57:19 2012

addpath('mex/');
N = round(logspace(1,5,10))';                   % size of neighbor set
num_images = 5;                                 % # of images to use to estimate pdf
num_trials = 25;

% Kernel Density estimate
H_kde = zeros(length(N),num_trials);

% Nearest Neighbor estimate
H_nn = zeros(length(N),num_trials);

% Theoretical entropy estimate
%H_theory = log2(2*exp(1)*sqrt(0.5));
H_theory = 0.5*log2(2*pi*exp(1));

% get data
%data = [];
%for i = 1:num_images
    %img = loadimage(randi(50));
    %data = [data; img(:) + rand(size(img(:)))];        % dither
%end

for i = 1:length(N)

    progressbar(i,length(N));

    for t = 1:num_trials

        n = N(i);                                   % number of neighbors

        %samples = laprnd(n,1);
        samples = randn(n,1);

        md = mindist(samples);
        H_nn(i,t) = mean(log2(md)) + log2(2*n) - psi(1)/log(2);

        H_kde(i,t) = entropy(samples);                 % estimate entropy from PDF

    end

end

% Plots
%fig(1); clf;
%subplot(211); imgsc(img);
%subplot(212); plot(x,p,'k-'); makepretty;
%xlabel('x'); ylabel('p(x)');

% Plots
fig(1); clf;
semilogx(N, mean(H_nn,2), 'r*-', N, mean(H_kde,2), 'c*-', [N(1) N(end)], [H_theory H_theory], 'k--');
legend('NN estimate', 'KD estimate', 'True value');

save('../data/1Dnorm.mat');
