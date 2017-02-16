% s_TMRgFUS_t1wRoi.m
%
%
%
% Qiyuan Tian, McNab Lab, Stanford, Feb 2017

clear, clc, close all
dpRoot = rootpath;

%% 
subjects = {'s100307'};

%%
for ii = 1 : length(subjects) 
    sj = subjects{ii};
    disp(['***** ' sj ' *****']);
    
    dpSub = fullfile(dpRoot, sj);
    dpRoi = fullfile(dpSub, 'pre-diff-roi');
    mkdir(dpRoi);
    
    fpAparc = fullfile(dpSub, 'post-t1w-aparc', [sj '_aparc+aseg_epi.nii.gz']);
    
    % Look up table to thalamus and precentral cortices
    % https://surfer.nmr.mgh.harvard.edu/fswiki/FsTutorial/AnatomicalROI/FreeSurferColorLUT
    indices = [10, 49, 1024, 2024];
    labels = {'left_thalamus', 'right_thalamus', 'left_precentral', 'right_precentral'};
    
    for jj = 1 : length(indices)
        idx = indices(jj);
        fpRoi = fullfile(dpRoi, [sj '_roi_' labels{jj}]);
        
        cmd = ['fslmaths ' fpAparc ' -thr ' num2str(idx) ' -uthr ' num2str(idx) ' ' fpRoi];
        [status, cmdout] = system(cmd, '-echo');
    end
    
end



