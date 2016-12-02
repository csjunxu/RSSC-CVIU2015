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

clc, clear all, close all

addpath(genpath(fullfile(pwd)));

% Please download FBMS137 dataset at http://wangliuqing.tk/Publications.html
cd '../../data/FBMS137';

alpha = 753;
ep1 = 0.0002;
ep2 = 0.0014;
maxNumGroup = 5;
for i = 1:maxNumGroup
    num(i) = 0;
end
d = dir;
for i = 1:length(d)
    if ( (d(i).isdir == 1) && ~strcmp(d(i).name,'.') && ~strcmp(d(i).name,'..') )
        filepath = d(i).name;
        eval(['cd ' filepath]);
        
        f = dir;
        foundValidData = false;
        for j = 1:length(f)
            if ( ~isempty(strfind(f(j).name,'_truth.mat')) )
                ind = j;
                foundValidData = true;
                break
            end
        end
        eval(['load ' f(ind).name]);
        cd ..
        
        if (foundValidData)
            n = max(s);
            N = size(x,2);
            F = size(x,3);
            D = 2*F;
            X = reshape(permute(x(1:2,:,:),[1 3 2]),D,N);
            
            r = 0; affine = true; outlier = false; rho = 0.7;
            missrate1= RSSC(X,r,affine,alpha,ep1,ep2,outlier,rho,s);
            
            r = 4*n; affine = true; outlier = false; rho = 0.7;
            time02 =   clock;
            missrate2 = RSSC(X,r,affine,alpha,ep1,ep2,outlier,rho,s);
            
            num(n) = num(n) + 1;
            missrateTot1{n}(num(n)) = missrate1;
            missrateTot2{n}(num(n)) = missrate2;
            
            eval(['cd ' filepath]);
            cd ..
        end
    end
end


L = 2;
allmissrate1 = [];
allmissrate2 = [];
for i = 1:length(L)
    j = L(i);
    avgmissrate1(j) = mean(missrateTot1{j});
    medmissrate1(j) = median(missrateTot1{j});
    allmissrate1 = [allmissrate1 missrateTot1{j}];
    
    avgmissrate2(j) = mean(missrateTot2{j});
    medmissrate2(j) = median(missrateTot2{j});
    allmissrate2 = [allmissrate2 missrateTot2{j}];
end
avgallmissrate1 = sum(allmissrate1)/length(allmissrate1);
medallmissrate1 = median(allmissrate1);
avgallmissrate2 = sum(allmissrate2)/length(allmissrate2);
medallmissrate2 = median(allmissrate2);
save('RSSC_FB.mat','avgallmissrate1','medallmissrate1','missrateTot1','avgmissrate1','medmissrate1','avgallmissrate2','medallmissrate2','missrateTot2','avgmissrate2','medmissrate2');