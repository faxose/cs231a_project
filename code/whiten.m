% Whitens data via PCA
% Niru Maheswaranathan
% Tue Nov  6 10:41:51 2012
% [X U S V R P] = whiten(X)
% X is the data, rows are observations, columns are variables

function [Z Zr W data] = whiten(X, rdim, method)

    if nargin < 3       % choose method based on # of samples
        if size(X,1) > 5e3
            method = 'eig';
        else
            method = 'svd';
        end
    end
    data.method = method;

    % center the data
    xdc = removeDC(X);

    if strcmp(method, 'svd') == 1

        fprintf('Whitening via SVD:\n');
        progressbar(1,4);

        % SVD
        progressbar(2,4);
        [data.U data.S data.V] = svd(xdc);

        % Rotation operator
        progressbar(3,4);
        data.R = data.V(:,1:rdim);

        % Scaling Operator
        progressbar(4,4);
        data.P = data.S(1:rdim,1:rdim);

        % Whiten
        W = data.R*pinv(data.P)*data.R';
        Zr = xdc*data.R;
        Z  = Zr*pinv(data.P);

    elseif strcmp(method, 'eig') == 1

        fprintf('Whitening via EIG:\n');
        progressbar(1,4);

        % covariance matrix
        progressbar(2,4);
        data.C = cov(xdc);

        % eigendecomposition
        progressbar(3,4);
        [V D] = eig(data.C);

        % sort by largest eigenvalues
        progressbar(4,4);
        [data.D, data.indices] = sort(diag(D), 'descend');
        data.V = V(:,data.indices);

        % whiten data
        W = data.V(:,1:rdim)*diag(data.D(1:rdim).^(-0.5))*data.V(:,1:rdim)';
        Zr = xdc*data.V(:,1:rdim);
        Z = Zr*diag(data.D(1:rdim).^(-0.5));

    end
