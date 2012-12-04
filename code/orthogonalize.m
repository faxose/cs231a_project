% Orthogonalize rows of a matrix
% Niru Maheswaranathan
% Tue Nov  6 16:51:27 2012

function U = orthogonalize(W)

    U = real((W*W')^(-0.5))*W;
