% s_TMRgFUS_diffBbrT1w.m
%
%
%
% Qiyuan Tian, McNab Lab, Stanford, Feb 2017

clear, clc, close all
dpRoot = rootpath();

%% 
subjects = {'s100307'};

%%
for ii = 1 : length(subjects)
    sj = subjects{ii}; % subject
    disp(['***** ' sj ' *****']);

    dpSub = fullfile(dpRoot, sj); % subject path
    dpBbr = fullfile(dpSub, 'pre-diff-bbr');
    mkdir(dpBbr);
    
    dpSurf = fullfile(dpSub, 'post-t1w-surf');
    setenv('SUBJECTS_DIR', dpSurf);
    
    % needed files
    fpS0 = fullfile(dpSub, 'pre-diff-dti', [sj '_diff_dti_S0.nii.gz']);
    fpT1w = fullfile(dpSurf, sj, 'mri', 'brain.mgz');    
    
    fpT1wEpiMgz = fullfile(dpBbr, [sj '_t1w_epi.mgz']);
    fpT1wEpiNii = fullfile(dpBbr, [sj '_t1w_epi.nii.gz']);   
    
    % bbr reg using fsl-flirt as init
    fpBbrDat = fullfile(dpBbr, 'register_bbr.dat');
    fpBbrMat = fullfile(dpBbr, 'register_bbr.mat');

    cmd = ['bbregister --s ' sj ' --T2 --init-fsl --mov ' fpS0 ' --reg ' fpBbrDat ' --fslmat ' fpBbrMat];
    [status, result] = system(cmd, '-echo');
    
    % register t1w to epi for reference
    cmd = ['mri_vol2vol --mov ' fpS0 ' --targ ' fpT1w ' --inv --o ' fpT1wEpiMgz ' --reg ' fpBbrDat ' --no-save-reg'];
    [status, result] = system(cmd, '-echo');

    cmd = ['mri_convert ' fpT1wEpiMgz ' ' fpT1wEpiNii];        
    [status, result] = system(cmd, '-echo'); 
end
