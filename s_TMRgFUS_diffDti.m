% s_TMRgFUS_diffDti.m
%
% Fit tensor model using FSL function dtifit.
%
%
% Qiyuan Tian, McNab Lab, Stanford, Feb 2017 

clear, clc, close all
dpRoot = rootpath();

%% 
subjects = {'s100307'};

%%
for ii = 1 : length(subjects)
    sj = subjects{ii};
    disp(['***** ' sj ' *****']);

    dpSub = fullfile(dpRoot, sj);
    dpDiff = fullfile(dpSub, 'pre-diff');
    dpBmask = fullfile(dpSub, 'pre-diff-bmask');
    dpDti = fullfile(dpSub, 'pre-diff-dti');
    mkdir(dpDti);
    
    fpDiff = fullfile(dpDiff, [sj '_diff.nii.gz']);
    fpBval = fullfile(dpDiff, [sj, '_diff.bval']);
    fpBvec = fullfile(dpDiff, [sj, '_diff.bvec']);
    fpBmask = fullfile(dpBmask, [sj '_diff_masked_mask.nii.gz']);
    fpDti = fullfile(dpDti, [sj '_diff_dti']);
    
    % dti fit
    cmd = ['dtifit -k ' fpDiff ' -o ' fpDti ' -m ' fpBmask ' -r ' fpBvec ' -b ' fpBval];
    [status, cmdout] = system(cmd, '-echo');
end