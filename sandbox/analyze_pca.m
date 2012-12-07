% analyze scripted results
% Niru Maheswaranathan
% Fri Nov 30 17:49:55 2012

H = zeros(9,20);

for k = 1:9
    sim = load(['data/pca_3x3_' num2str(k) '.mat']);
    H(k,:) = (sim.H_nn)./(k^2);
    N = sim.N;
end

fig(1);
semilogx(N,H','o-');
xlabel('# of Samples');
