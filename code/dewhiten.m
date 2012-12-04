% Dewhitens data
% Niru Maheswaranathan
% Wed Nov  7 13:37:39 2012
% X = dewhiten(Z,P,R)

function [X Xr] = dewhiten(Z, data)

    %Transform back to original space from whitened space
    if strcmp(data.method, 'svd') == 1
        Xr = Z*data.R';
        X  = Z*data.P*data.R';
    elseif strcmp(data.method, 'eig') == 1
        Xr = Z*data.V(:,1:size(Z,2))';
        X  = Z*diag(data.D(1:size(Z,2)).^0.5)*data.V(:,1:size(Z,2))';
    end
