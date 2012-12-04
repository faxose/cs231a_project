% Runs ICA on natural image patches
% Niru Maheswaranathan
% Tue Nov  6 10:34:45 2012

% Parameters
patch_size = 32;
num_patches = 5e4;
reduced_dim = 144;
num_features = 42;
epsilon = 1e-4;

% Load some images
tic;
fprintf('Loading images ...\n');
X = generate_samples(num_patches, patch_size, 'model','natural', 'num_images',50);
fprintf('Done.\n\n');

% Preprocess (center and whiten)
fprintf('Whitening data ...\n');
[Z Zr A data] = whiten(X,reduced_dim,'eig');
fprintf('Done.\n\n');

% run ICA
fprintf('Running ICA ...\n');

% Initialize orthogonal filters
W = orthogonalize(randn(num_features, reduced_dim));

iter = 0;
hasConverged = 0;

while (hasConverged == 0) && (iter<2000) %maximum of 2000 iterations

    % update
    iter = iter + 1;

    % Store old value
    Wold=W;

    % Compute estimates of independent components
    Y=W*Z';

    % ICA objective function
    W = tanh(Y)*Z/num_patches - (mean(1-tanh(Y)'.^2)'*ones(1,size(W,2))).*W;

    % Orthogonalize rows or decorrelate estimated components
    W = orthogonalize(W);

    % Check if converged
    convergence = norm(abs(W*Wold')-eye(num_features),'fro');
    if  convergence < epsilon*num_features;
        hasConverged = 1;
    end

    % update
    fprintf('%1.0f) Convergence: %6.5f.\n',iter,convergence);

end

% Project back into original space
[F Fr] = dewhiten(W,data);
toc;
