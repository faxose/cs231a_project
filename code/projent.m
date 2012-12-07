
% basis functions: Vp, F, X

ICAent = zeros(42,1);
PCAent = zeros(42,1);

xica = X*F;
xpca = X*Vp;

for j = 1:42

    ICAent(j) = entropy(xica(:,j));
    PCAent(j) = entropy(xpca(:,j));

end
