% analyze scripted results
% Niru Maheswaranathan
% Fri Nov 30 17:49:55 2012

D = (1:4).^2;
N = round(logspace(1,6,10));
H = -1*ones(length(D), length(N));
runtimes = -1*ones(size(H));

for k = 1:length(D)
    for j = 1:length(N)
        %try
            sim = load(['../data/sim_k' num2str(k) '_n' num2str(N(j)) '.mat']);
            H(k,j) = (sim.H_nn)./(sim.k^2);
            runtimes(k,j) = sim.runtime/3600;
        %catch exception
            %H(k,j) = NaN;
            %runtimes(k,j) = NaN;
        %end
    end
end

subplot(122);
loglog(N,runtimes','o-');
xlabel('# of Samples');
ylabel('Runtime (hours)');

subplot(121);
semilogx(N,H','o-');
xlabel('# of Samples');
ylabel('Entropy (bits/pixel)');
