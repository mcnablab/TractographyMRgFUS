% s_TMRgFUS_diffStats.m
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
    
    dpSeed = fullfile(dpSub, 'pre-diff-seed');
    dpLesion = fullfile(dpSub, 'post-t1w-lesion');
    dpStats = fullfile(dpSub, 'stats');
    mkdir(dpStats);
    
    tmp = dir(fullfile(dpLesion, '*lesion*'));
    fnLesion = tmp.name;
    fpLesion = fullfile(dpLesion, fnLesion);
    
    if strfind(lower(fnLesion), 'left')
        fpSeed = fullfile(dpSeed, [sj '_seed_left.nii.gz']);
    elseif strfind(lower(fnLesion), 'right')
        fpSeed = fullfile(dpSeed, [sj '_seed_right.nii.gz']);
    else
        error('Double check lesion files!');
    end
    
    % number of lesion voxels
    cmd = ['fslstats ' fpLesion ' -V'];
    [status, results] = system(cmd);
    voxnum = str2double(results(1 : strfind(results, ' ') - 1));
    
    % number of streamlines within lesion
    fpSeedInLesion = fullfile(dpStats, 'seed_in_lesion');
    cmd = ['fslmaths ' fpSeed ' -mul ' fpLesion ' ' fpSeedInLesion];
    [status, results] = system(cmd);
    
    cmd = ['fslstats ' fpSeedInLesion ' -M'];
    [status, results] = system(cmd);
    
    % write results
    fpStats = fullfile(dpStats, 'streamline_number.txt');
    strmlnum = str2double(results) * voxnum;
    dlmwrite(fpStats, strmlnum, 'delimiter', ' ');
end
























