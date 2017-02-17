% s_TMRgFUS_diffNormSeed.m
%
%
%
% Qiyuan Tian, McNab Lab, Stanford, Feb 2017

clear, clc, close all
dpRoot = rootpath;

%% Subjects
subjects = {'s100307'};

%%
for ii = 1 : length(subjects)
    sj = subjects{ii}; 
    dpSub = fullfile(dpRoot, sj); 
    
    dpTrack = fullfile(dpSub, 'pre-diff-track');
    dpSeed = fullfile(dpSub, 'pre-diff-seed');
    mkdir(dpSeed);
    
    fpLseed = fullfile(dpTrack, ['seeds_to_' sj '_roi_left_precentral.nii.gz']);
    fpRseed = fullfile(dpTrack, ['seeds_to_' sj '_roi_right_precentral.nii.gz']);

    fpLwt = fullfile(dpTrack, [sj '_wt_left']);
    fpRwt = fullfile(dpTrack, [sj '_wt_right']);

    fpLseedNorm = fullfile(dpSeed, [sj '_seed_left.nii.gz']);
    fpRseedNorm = fullfile(dpSeed, [sj '_seed_right.nii.gz']);
    
    % left 
    lwt = dlmread(fpLwt);
    cmd = ['fslmaths ' fpLseed ' -div ' num2str(lwt) ' ' fpLseedNorm];
    [status, result] = system(cmd, '-echo');
    
    % right
    rwt = dlmread(fpRwt);
    cmd = ['fslmaths ' fpRseed ' -div ' num2str(rwt) ' ' fpRseedNorm];
    [status, result] = system(cmd, '-echo');
end
























