% computes entropy over the distribution of single pixel values
% Niru Maheswaranathan
% Sat Nov  3 10:47:43 2012

images = struct;
for j = 1:4212

    % Progress
    fprintf('%1.0f of %1.0f.\n',j,4212);

    % load image
    try
        img = loadimage(j);
    catch exception
        fprintf('Image %1.0f is corrupted.\n',j);
        continue;
    end

    % get kernel density estimate of whole image
    %[f,xi] = ksdensity(img(:));
    [bw f xi] = kde(img(:));
    images(j).x = xi;
    images(j).p = f;

    % estimate entropy
    try
        images(j).H = entropy(f,xi);
    catch exception
        fprintf('Bad density estimate for image %1.0f.\n',j);
        images(j).H = -1;
    end

end
