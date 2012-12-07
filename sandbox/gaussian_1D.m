% Entropy estimation of a 1D Gaussian
% via NN and KD estimates
% Niru Maheswaranathan
% Sat Nov  3 18:57:19 2012

%addpath('mex/');
N = round(logspace(1,4,20))';                   % size of neighbor set
sigmasq = 4;
k = 1;

% Theoretical entropy estimate
H_theory = 0.5*log2(2*pi*exp(1)*sigmasq);

% Kernel Density estimate
H_kde = zeros(length(N),1);

% Nearest Neighbor estimate
H_nn = zeros(length(N),1);
%Ak = sqrt(pi)/gamma(1.5);
Ak = (k*pi^(k/2))/gamma(k/2+1);

for i = 1:length(N)

    progressbar(i,length(N));
    n = N(i);                                   % number of neighbors

    samples = sqrt(sigmasq)*randn(n,1);         % draw samples

    %distmex = build(n,[samples zeros(n,1)]);    % NN distances
    %distmex = distmex + distmex' + 1e3*eye(n);  % fix distance matrix
    %mindist = min(distmex);                     % get minimum distances

    distmat = dist(samples');
    distmat = distmat + 1e2*eye(n);
    mindist = min(distmat);

    %H_nn(i) = (mean(log(n*mindist)) + log(2) - psi(1)).*(log2(10)/log(10));
    H_nn(i) = mean(log2(mindist)) + log2(n*Ak/k) - psi(1)/log(2);

    [bw p x] = kde(samples);                    % kernel density estimate
    H_kde(i) = entropy(p,x);                    % estimate entropy from PDF

end

% Plots
fig(1); clf;
semilogx(N, H_nn, 'r*-', N, H_kde, 'c*-', [N(1) N(end)], [H_theory H_theory], 'k--');
legend('NN estimate', 'KD estimate', 'True value');

fig(2); clf;
semilogx(N, abs(H_nn-H_theory), 'r*-', N, abs(H_kde-H_theory), 'c*-');
legend('NN error', 'KD error');

%distances = zeros(T,length(N));
%DN = zeros(length(N),1);

%for j = 1:length(N)

    %n = N(j);                           % number of neighbors

    %for i = 1:T                         % for each target

        %progressbar(i,T);
        %target = randn(dim,1);
        %mindist = Inf;

        %for k = 1:n                     % for each neighbor

            %neighbor = randn(dim,1);    % generate neighbor
            %dist = sqrt(sum((target-neighbor).^2));

            %% check if minimum distance
            %if dist < mindist
                %mindist = dist;
            %end

        %end

        %% store minimum distance
        %distances(i,j) = mindist;
        %DN(j) = mean(log2(distances(:,j)));

    %end

%end

%%H = dim*DN(end)
