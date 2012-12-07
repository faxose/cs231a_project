% Correlation between pixels as a function of distance
% Niru Maheswaranathan
% Tue Dec  4 13:53:37 2012

% Parameters
patch_size = 12;
idx = ceil(patch_size/2);
num_patches = 1e4;

% Load some images
tic;
fprintf('Loading images ...\n');
X = generate_samples(num_patches, patch_size, 'model','natural', 'num_images',50);
fprintf('Done.\n\n');

% compute cross-correlation
rho = corr(X);
R = reshape(rho(:,sub2ind([patch_size patch_size],idx,idx)),patch_size,patch_size);

% image
figure(1);
imgsc(R,[0 1]);
