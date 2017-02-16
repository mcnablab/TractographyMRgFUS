% s_TMRgFUS_t1wAparc.m
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
    disp(['***** ' sj ' *****']);

    dpSub = fullfile(dpRoot, sj);
    dpSr = fullfile(dpSub, 'post-t1w-surf');
    setenv('SUBJECTS_DIR', dpSr);
    
    dpAparc = fullfile(dpSub, 'post-t1w-aparc');
    mkdir(dpAparc);
    
    fpBbrDat = fullfile(dpSub, 'pre-diff-bbr', 'register_bbr.dat');
    fpS0 = fullfile(dpSub, 'pre-diff-dti', [sj '_diff_dti_S0.nii.gz']);
    
    fpAparc = fullfile(dpSr, sj, 'mri', 'aparc+aseg.mgz');
    fpAparcEpiMgz = fullfile(dpAparc, [sj '_aparc+aseg_epi.mgz']);
    fpAparcEpiNii = fullfile(dpAparc, [sj '_aparc+aseg_epi.nii.gz']);

    cmd = ['mri_vol2vol --mov ' fpS0 ' --targ ' fpAparc ' --inv --interp nearest --o ' fpAparcEpiMgz ' --reg ' fpBbrDat ' --no-save-reg'];
    [status, result] = system(cmd, '-echo');

    cmd = ['mri_convert ' fpAparcEpiMgz ' ' fpAparcEpiNii];        
    [status, result] = system(cmd, '-echo');
end
