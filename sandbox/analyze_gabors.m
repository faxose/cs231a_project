% analyze gabor functions
% Niru Maheswaranathan
% Sun Dec  2 15:00:49 2012

ns = load('../data/gabors.mat');
%load('data/gabors_whitenoise.mat');
cwn = load('../data/gabors_coloredwhitenoise.mat');

plot(cwn.thetas,cwn.H(:,end),'r.-', ns.thetas,ns.H(:,end),'b.-','MarkerSize',35);
