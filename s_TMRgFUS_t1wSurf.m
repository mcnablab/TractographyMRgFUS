% s_TMRgFUS_t1wSurf.m
%
%
%
% (c) Qiyuan Tian, McNab Lab, Stanford, 2016 July

clear, clc, close all
dpRoot = rootpath;

%% Subjects
subjects = {'s100307'};

%%
for ii = 1 : length(subjects)
    sj = subjects{ii}; % subject
    disp(['***** ' sj ' *****']);
    
    dpSub = fullfile(dpRoot, sj); % subject path
    dpSurf = fullfile(dpSub, 'post-t1w-surf');
    mkdir(dpSurf);
    setenv('SUBJECTS_DIR', dpSurf);
    
    fpT1w = fullfile(dpSub, 'post-t1w', [sj '_t1w.nii.gz']);
    cmd = ['recon-all -i ' fpT1w ' -subjid ' sj ' -all'];
    [status, result] = system(cmd, '-echo');
    
    cmd = ['rm -rf ' fullfile(dpSurf, '*average')];
    [status, result] = system(cmd, '-echo');
end
