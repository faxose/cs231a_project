% Estimating the entropy of a N-dimensional Gaussian
% Niru Maheswaranathan
% Sat Nov  3 12:47:08 2012

dim = 1;                       % size of patch
N = round(logspace(2,5,10));    % number of samples
%C = randn(dim); C = C*C';       % covariance
C = eye(dim);
%T = 100;                         % # of targets

H_theory = 0.5*log2((2*pi*exp(1))^dim*det(C));
H_nn = zeros(length(N),1);

tic;
for j = 1:length(N)

    progressbar(j,length(N));
    n = N(j);

    % generate samples
    x = mvnrnd(zeros(n,dim), C);

    % find minimum distances
    T = round(0.1*n);
    indices = randperm(n); %(n,T,1);
    if T > 1e3
        T = 1e3;
    end

    if T <= 1e3
        %% Method 1
        distances = distance(x',x(indices(1:T),:)');
        distances(distances==0) = 1e3;
        mindist = min(distances);
        clear distances;
    else
        % Method 2
        mindist = zeros(T,1);
        for i = 1:T
            idx = indices(i);
            dists = sqrt(sum((x - ones(n,1)*x(idx,:)).^2,2));
            dists(idx) = [];
            mindist(i) = min(dists);
        end
    end

    %H_nn(j) = mean(log2(mindist));% + log(2) - psi(1)).*(log2(10)/log(10));
    H_nn(j) = (mean(log(n*mindist)) + log(2) - psi(1)).*(log2(10)/log(10));

end
toc;

fig(1);
semilogx(N, H_nn, 'k.', [N(1) N(end)], [H_theory H_theory], 'c--');
xlabel('# of samples (n)'); ylabel('Entropy (bits)');
