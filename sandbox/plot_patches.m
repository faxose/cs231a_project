% Plot image patches on grid
% Niru Maheswaranathan
% Tue Nov  6 15:12:17 2012
% h = plot_patches(X,num,shuffle)

function h = plot_patches(X,num,shuffle)

    if nargin < 3
        shuffle = 1;
    end

    if nargin < 2
        num = min(42,size(X,1));
    end

    if shuffle
        indices = randperm(size(X,1));
    else
        indices = 1:size(X,1);
    end

    X = X(indices(1:num),:);
    D = sqrt(size(X,2));
    m = ceil(sqrt(size(X,1)));
    n = ceil(size(X,1)/m);
    h = zeros(size(X,1),1);

    for j = 1:size(X,1)
        subplot(n,m,j);
        h(j) = imagesc(reshape(X(j,:),D,D));
        set(gca,'XTick',[],'YTick',[]);
        axis image;
    end

    colormap gray;
