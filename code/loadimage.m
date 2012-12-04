% loads an "iml" image from the van Hateren database
% Niru Maheswaranathan
% October 6th, 2012
% img = loadimage(idx)

function img = loadimage(idx)

    if idx < 1 || idx > 50 || round(idx) ~= idx
        error('Index must be between 1 and 50.');
    end

    % width and height
    w = 1536; h = 1024;

    % generate filename
    prefix = '~/Documents/Data/images/';                                                 % image folder
    fname = [prefix sprintf('imk%05.0f.iml',idx)];                      % filename

    % load file
    file = fopen(fname,'rb','ieee-be');                                 % open file
    if file == -1
        error('Invalid file index.');
    end

    % read image
    img = fread(file, [w, h], 'uint16')';                               % load image
    fclose(file);
