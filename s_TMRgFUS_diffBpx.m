% s_TMRgFUS_diffBpx.m
%
% Fit ball and stick model using FSL function bedpostx.
%
% Fitting process usually takes long time with CPU, especially for
% high-resolution diffusion data. It's better to use GPU and computing
% cluster i.e. sherlock clustet locally at Stanford. Contact QT or sherlock
% staff for details.
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
    dpBpx = fullfile(dpSub, 'pre-diff-bpx');
    mkdir(dpBpx);
    
    fpDiff = fullfile(dpDiff, [sj '_diff.nii.gz']);
    fpBval = fullfile(dpDiff, [sj, '_diff.bval']);
    fpBvec = fullfile(dpDiff, [sj, '_diff.bvec']);
    fpMask = fullfile(dpBmask, [sj '_diff_masked_mask.nii.gz']);
    
    copyfile(fpDiff, fullfile(dpBpx, 'data.nii.gz'));
    copyfile(fpBval, fullfile(dpBpx, 'bvals'));
    copyfile(fpBvec, fullfile(dpBpx, 'bvecs'));
    copyfile(fpMask, fullfile(dpBpx, 'nodif_brain_mask.nii.gz'));

    % bedpostx fit using default parameters
    cmd = ['bedpostx ' dpBpx];
    [status,result] = system(cmd);
end























