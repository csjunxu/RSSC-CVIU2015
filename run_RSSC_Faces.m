%----------------------------------------------------------------------------------------------------
% This is the main function to run the RSSC algorithm for the motion
% segmentation problem on the Hopkins 155 dataset.
% avgmissrate1: the n-th element contains the average clustering error for
% sequences with n motions (using 2F-dimensional data)
% avgmissrate2: the n-th element contains the average clustering error for
% sequences with n motions (using 4n-dimensional data)
% medmissrate1: the n-th element contains the median clustering error for
% sequences with n motions (using 2F-dimensional data)
% medmissrate2: the n-th element contains the median clustering error for
% sequences with n motions (using 4n-dimensional data)
%----------------------------------------------------------------------------------------------------
% Please cite the following article if the code is helpful for you.
% Jun Xu, Kui Xu, Ke Chen, Jishou Ruan. "Reweighted Sparse Subspace Clustering", 
% Accepted by Computer Vision and Image Understanding, 2015.
%----------------------------------------------------------------------------------------------------
% Copyright @ Jun Xu, 2015
% Please Contact csjunxu@comp.polyu.edu.hk for any questions.
%----------------------------------------------------------------------------------------------------

clear all, close all,clc;

load YaleBCrop025.mat

alpha = 20;
ep1 = 9e-3;
ep2 = 2.7e-4;

for nSet = [2 3 4 5 6 7 8 9 10]
    for i = 1:length(nSet)
        n = nSet(i);
        idx = Ind{n};
        for j = 1:size(idx,1)
            X = [];
            for p = 1:n
                X = [X Y(:,:,idx(j,p))];
            end
            [D,N] = size(X);
            
            r = 0; affine = false; outlier = true; rho = 1;
            time0  =   clock;
            missrate = RSSC(X,r,affine,alpha,ep1,ep2,outlier,rho,s{n});
            missrateTot{n}(j) = missrate;
        end
        avgmissrate(n) = mean(missrateTot{n});
        medmissrate(n) = median(missrateTot{n});
        save RSSC_Faces.mat missrateTot avgmissrate medmissrate alpha ep1 ep2
    end
    save RSSC_Faces.mat missrateTot avgmissrate medmissrate alpha ep1 ep2
end