function missrate = RSSC(X,r,affine,alpha,ep1,ep2,outlier,rho,s)

if (nargin < 8)
    rho = 1;
end
if (nargin < 7)
    outlier = false;
end
if (nargin < 6)
    alpha = 20;
end
if (nargin < 5)
    affine = false;
end
if (nargin < 4)
    r = 0;
end
n = max(s);
if r==0
    Xp = X ;
else
    [ eigvector , ~ ] = PCA( X ) ;
    Xp = eigvector(:,1:r)' * X ;
end

if (~outlier)
    CMat = admmLasso_mat_func(Xp,affine,alpha,ep1,ep2);
    C = CMat;
else
    CMat = admmOutlier_mat_func(Xp,affine,alpha,ep1,ep2);
    N = size(Xp,2);
    C = CMat(1:N,:);
end
CKSym = BuildAdjacency(thrC(C,rho));
grps = SpectralClustering(CKSym,n);
missrate = compacc_ce(grps,s);