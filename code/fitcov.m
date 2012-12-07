% covariance models of image patches
% Niru Maheswaranathan
% Tue Dec  4 15:52:00 2012

% Parameters
num_patches = 5e4;

for k = 1:12

    % Load some images
    tic;
    fprintf('%1.0f) Loading images ... ',k);
    X = generate_samples(num_patches, k, 'model','natural', 'num_images',50);
    %X = X*(255/max(X(:)));
    fprintf('Done.\n');

    %xdc = removeDC(X);
    C = cov(X);

    H(k) = 0.5*log2( (2*pi*exp(1))^(k*k)*det(C) )/(k*k);

    toc;
end
