% s_TMRgFUS_diffBmask.m
%
%
%
% Qiyuan Tian, McNab Lab, Stanford, 2017 February

clear, clc, close all
dpRoot = rootpath();

%% 
subjects = {'s100307'};

%%
for ii = 1 : length(subjects)
    sj = subjects{ii}; % subject
    disp(['***** ' sj ' *****']);

    dpSub = fullfile(dpRoot, sj); % subject path
    dpBmask = fullfile(dpSub, 'pre-diff-bmask');
    mkdir(dpBmask);
    
    % extract b0 images
    fpDiff = fullfile(dpSub, 'pre-diff', [sj '_diff.nii.gz']);
    fpBval = fullfile(dpSub, 'pre-diff', [sj '_diff.bval']);
    bval = dlmread(fpBval);
    
    cmd = ['fslsplit ' fpDiff ' ' fullfile(dpBmask, 'vol') ' -t'];
    [status, result] = system(cmd, '-echo');
    
    for jj = 1 : length(bval);
        b = bval(jj);
        fpDwi = fullfile(dpBmask, ['vol' num2str(jj - 1, ['%0' num2str(4) '.f']) '.nii.gz']);
        if b > 500
            delete(fpDwi);
        end
    end
    
    fpB0 = fullfile(dpBmask, [sj '_diff_b0']);
    cmd = ['fslmerge -t ' fpB0 ' ' fullfile(dpBmask, 'vol*')];
    
    [status, result] = system(cmd, '-echo');
    delete(fullfile(dpBmask, 'vol*'));
    
    % average b0 image for improved signal-to-noise ratio
    fpB0Mean = fullfile(dpBmask, [sj '_diff_b0mean']);
    cmd = ['fslmaths ' fpB0 ' -Tmean ' fpB0Mean];
    [status,result] = system(cmd);
    
    % use FSL's bet2 to create brain mask
    % adapt -f number for different datasets
    fpDiffMasked = fullfile(dpBmask, [sj '_diff_masked']);
    cmd = ['bet2 ' fpDiff ' ' fpDiffMasked ' -f 0.2 -m'];
    [status, result] = system(cmd);    
end

















