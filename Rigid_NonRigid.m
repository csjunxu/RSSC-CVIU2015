%----------------------------------------------------------------------------------------------------
% Code for analyzing the performance on rigid and non-rigid motion segmentation
% Copyright @ Jun Xu, 2015.
% Contact : csjunxu@comp.polyu.edu.hk
%----------------------------------------------------------------------------------------------------

clc, clear all

load 'RSSC_FB.mat'
R1_1 = mean(missrateTot1{2}(1:22));
R1_2 = median(missrateTot1{2}(1:22));
NR1_1 = mean(missrateTot1{2}(23:64));
NR1_2 = median(missrateTot1{2}(23:64));

R2_1 = mean(missrateTot2{2}(1:22));
R2_2 = median(missrateTot2{2}(1:22));
NR2_1 = mean(missrateTot2{2}(23:64));
NR2_2 = median(missrateTot2{2}(23:64));
save RSSC_RNR.mat alpha missrateTot1 missrateTot2 avgmissrate1 medmissrate1 avgmissrate2 medmissrate2 R1_1 R1_2 NR1_1 NR1_2 R2_1 R2_2 NR2_1 NR2_2
