% Removes DC component from a signal
% Niru Maheswaranathan
% Tue Nov  6 10:40:24 2012
% [y mu] = removeDC(x)

function [y mu] = removeDC(x)

    mu = mean(x,2);
    y = x - mu*ones(1,size(x,2));
