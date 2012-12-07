% Computes nearest neighbor distance
% Niru Maheswaranathan
% Sat Nov  3 21:48:00 2012
% rho = nearest_neighbor(neighbors, targets)

function rho = nearest_neighbor(neighbors, targets, n)

    mindist = zeros(size(targets,2),1);
    for i = 1:size(targets,2)

        target = targets(:,i);                                  % get this target
        indices = randi(size(neighbors,2),n,1);                 % pick out n neighbors
        mindist(i) = Inf;                                       % store minimum distance

        for j = 1:length(indices)                               % for each neighbor

            dist = norm(target - neighbors(:,indices(j)));      % compute NN distance

            % store if minimum distance
            if dist < mindist(i)
                mindist(i) = dist;
            end

        end

    end
    rho = mindist;
