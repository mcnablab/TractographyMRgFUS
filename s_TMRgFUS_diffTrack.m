% s_TMRgFUS_diffTrack.m
% 
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
    sj = subjects{ii};
    disp(['***** ' sj ' *****']);
    
    dpSub = fullfile(dpRoot, sj);
    dpRoi = fullfile(dpSub, 'pre-diff-roi');
    dpTrack = fullfile(dpSub, 'pre-diff-track');
    mkdir(dpTrack);
    
    % track fibers using FSL's probtrackx2
    fpBpx = fullfile(dpSub, 'pre-diff-bpx.bedpostX', 'merged');
    fpMask = fullfile(dpSub, 'pre-diff-bpx.bedpostX', 'nodif_brain_mask');
    
    fpLtha = fullfile(dpRoi, [sj '_roi_left_thalamus.nii.gz']);    
    fpRtha = fullfile(dpRoi, [sj '_roi_right_thalamus.nii.gz']);    
    fpLprec = fullfile(dpRoi, [sj '_roi_left_precentral.nii.gz']);
    fpRprec = fullfile(dpRoi, [sj '_roi_right_precentral.nii.gz']);
                
    fnLtrack = [sj '_track_left'];
    fnRtrack = [sj '_track_right'];
    
    fpWt = fullfile(dpTrack, 'waytotal');
    fpLwt = fullfile(dpTrack, [sj '_wt_left']);
    fpRwt = fullfile(dpTrack, [sj '_wt_right']);
    
    % left thalumus to handknob
    cmd = ['probtrackx2 -s ' fpBpx ' -m ' fpMask ' -o ' fnLtrack ' -x ' fpLtha ' --targetmasks=' fpLprec ' --waypoints=' fpLprec ' --forcedir --opd -l --os2t --dir=' dpTrack];
    [status, result] = system(cmd, '-echo');    
    movefile(fpWt, fpLwt);
    
    % right thalumus to handknob
    cmd = ['probtrackx2 -s ' fpBpx ' -m ' fpMask ' -o ' fnRtrack ' -x ' fpRtha ' --targetmasks=' fpRprec ' --waypoints=' fpRprec ' --forcedir --opd -l --os2t --dir=' dpTrack];
    [status, result] = system(cmd, '-echo');    
    movefile(fpWt, fpRwt);
end
























