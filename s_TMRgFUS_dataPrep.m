% s_TMRgFUS_dataPrep.m
%
% Prepare demo data from a single subject (100307) of the WU-UMinn Human
% Connectome Project (downloaded from https://www.humanconnectome.org).
%
% To mimic clinical diffusion data, a single shell of b=2000 is extracted
% and downsampled from 1.25mm isotropic resolution to 2.5mm isotropic
% resolution.
%
% The T1-weighted data is used to mimic the post-treatment images on which
% the induced lesions can be visulized. 
%
% Please note this demo data is only for demonstration of our analysis
% pipeline.
%
%
% Qiyuan Tian, McNab Lab, Stanford, Feb 2017

clear, clc, close all
dpRoot = rootpath;

%% subject
sj = 's100307';
fpZip = fullfile(dpRoot, '100307_3T_Diffusion_preproc.zip');

dpSub = fullfile(dpRoot, sj);
mkdir(dpSub);

%% unzip data
cmd = ['unzip ' fpZip ' -d ' dpRoot];
[status, result] = system(cmd, '-echo');

dpUnzip = fullfile(dpRoot, '100307');

%% diffusion
% extract b = 2000 data
dpDiff = fullfile(dpSub, 'pre-diff');
mkdir(dpDiff);

fpDiffFrom = fullfile(dpUnzip, 'T1w', 'Diffusion', 'data.nii.gz');
fpBvalFrom = fullfile(dpUnzip, 'T1w', 'Diffusion', 'bvals');
fpBvecFrom = fullfile(dpUnzip, 'T1w', 'Diffusion', 'bvecs');

fpDiffTo = fullfile(dpDiff, [sj '_diff.nii.gz']);
fpBvalTo = fullfile(dpDiff, [sj '_diff.bval']);
fpBvecTo = fullfile(dpDiff, [sj '_diff.bvec']);

bval = dlmread(fpBvalFrom)';
bvec = dlmread(fpBvecFrom)';

cmd = ['fslsplit ' fpDiffFrom ' ' fullfile(dpDiff, 'vol') ' -t'];
[status, result] = system(cmd, '-echo');

for jj = 1 : length(bval);
    b = bval(jj);
    fpDwi = fullfile(dpDiff, ['vol' num2str(jj - 1, ['%0' num2str(4) '.f']) '.nii.gz']);
    if (b > 500 && b < 1500) || b > 2500
        delete(fpDwi);
    end
end

cmd = ['fslmerge -t ' fpDiffTo ' ' fullfile(dpDiff, 'vol*')];
[status, result] = system(cmd, '-echo');
delete(fullfile(dpDiff, 'vol*'));

mask =  bval < 500 | (bval > 1500 & bval < 2500);
dlmwrite(fpBvalTo, bval(mask), 'delimiter', ' ');
dlmwrite(fpBvecTo, bvec(mask, :), 'delimiter', ' ');

% downsample high-res data to low-res 
cmd = ['fslmaths ' fpDiffTo ' -subsamp2 ' fpDiffTo];
[status, result] = system(cmd, '-echo');

%% structure
dpT1w = fullfile(dpSub, 'post-t1w');
mkdir(dpT1w);

fpT1wFrom = fullfile(dpUnzip, 'T1w', 'T1w_acpc_dc_restore_1.25.nii.gz');
fpT1wTo = fullfile(dpT1w, [sj '_t1w.nii.gz']);
copyfile(fpT1wFrom, fpT1wTo);

%% delete unzipped data
cmd = ['rm -rf ' dpUnzip];
[status, result] = system(cmd, '-echo');
