% Computes entropy (in bits) of a sampled distribution
% uses kernel density estimation
% Niru Maheswaranathan
% Sat Nov  3 10:32:43 2012
% H = entropy(x)

function H = entropy(samples)

    % estimate PDF
    [p x] = ksdensity(samples);

    % Check to make sure PDF sums to 1
    dx = row(diff(x)); dx = [dx(1) dx];
    if abs(sum(dx.*row(p)) - 1) > 0.15
        error('Probability distribution does not sum to 1, instead it sums to %4.3f', sum(dx.*row(p)));
    end

    % compute entropy
    H = -row(p).*log2(row(p)).*dx;
    H = sum(real(H(isfinite(H))));
