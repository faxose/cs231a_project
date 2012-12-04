% Samples image patches from different image models
% Niru Maheswaranathan
% Tue Nov  6 14:40:25 2012
% X = generate_samples(num_samples, patch_size, varargin);
% Optional Arguments:
%   Model: gaussian, natural, deadleaves
%       Gaussian: covariance (I)
%       Natural: num_images (10)
%       Dead Leaves: nbr_iter (5000), shape (disk,square)

function X = generate_samples(num_samples, patch_size, varargin)

    % Parse inputs
    p = inputParser;
    img_models = {'gaussian','natural','deadleaves'};
    defaultModel = 'gaussian';
    addRequired(p,'num_samples',@isnumeric);
    addRequired(p,'patch_size',@isnumeric);
    addOptional(p,'num_images',10,@isnumeric);
    addOptional(p,'covariance',-1,@isnumeric);
    addOptional(p,'nbr_iter',5e3,@isnumeric);
    addOptional(p,'offset',4,@isnumeric);
    addOptional(p,'shape','disk');
    addParamValue(p,'model',defaultModel,@(x) any(validatestring(x,img_models)));

    % set up global parameters
    parse(p,num_samples,patch_size,varargin{:});
    N = p.Results.num_samples;
    D = p.Results.patch_size;
    model = p.Results.model;

    % set up model specific parameters
    switch model

        %% GAUSSIAN WHITE NOISE %%
        case 'gaussian'

            if p.Results.covariance == -1
                C = eye(D^2);
            else
                C = p.Results.covariance;
            end

            X = randn(N,D^2)*sqrtm(C);

        %% NATURAL IMAGE PATCHES %%
        case 'natural'

            % initialize patch matrix
            X = zeros(N,D^2);

            % get number of image centers
            num_centers = ceil(N/p.Results.num_images);
            k = 1;

            for i = 1:p.Results.num_images

                % load an image
                img = loadimage(i);

                % pick random patch corners
                r = size(img,1); c = size(img,2);
                xr = randi(r-D,num_centers,1);
                xc = randi(c-D,num_centers,1);

                for j = 1:num_centers

                    % get patch
                    temp_patch = img(xr(j):(xr(j)+D-1), xc(j):(xc(j)+D-1));
                    X(k,:) = temp_patch(:)';

                    % increment
                    k = k + 1;
                    if k > N
                        break;
                    end

                end

                %progressbar(i,p.Results.num_images);

            end

        %% DEAD LEAVES %%
        case 'deadleaves'

            % initialize patch matrix
            X = zeros(N,D^2);
            options = struct;
            options.shape = p.Results.shape;
            options.nbr_iter = p.Results.nbr_iter;

            % get number of image centers
            num_centers = ceil(N/p.Results.num_images);
            k = 1;

            % generate images
            for i = 1:p.Results.num_images

                % generate an image
                img = compute_dead_leaves_image(512,3,options);

                % pick random patch corners
                r = size(img,1); c = size(img,2);
                xr = randi(r-D,num_centers,1);
                xc = randi(c-D,num_centers,1);

                for j = 1:num_centers

                    % get patch
                    temp_patch = img(xr(j):(xr(j)+D-1), xc(j):(xc(j)+D-1));
                    X(k,:) = temp_patch(:)';

                    % increment
                    k = k + 1;
                    if k > N
                        break;
                    end

                end

                progressbar(i,p.Results.num_images);

            end

    end

end
