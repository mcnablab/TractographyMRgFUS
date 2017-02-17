% s_TMRgFUS_main.m
%
%
%
% Qiyuan Tian, McNab Lab, Stanford, Feb 2017

% Prepare data (download 100307_3T_Diffusion_preproc.zip from HCP https://www.humanconnectome.org) 
s_TMRgFUS_dataPrep

% Create brain mask for diffusion data
s_TMRgFUS_diffBmask

% Fit tensor model for diffusion data
s_TMRgFUS_diffDti

% Fit bedpostx model for diffusion data
s_TMRgFUS_diffBpx

% Reconstruct cortical surface from T1w data
s_TMRgFUS_t1wSurf

% Co-register t1w and diffusion data using boundary based registration
s_TMRgFUS_diffBbrT1w

% Convert freesurfer brain region labels from t1w space to diffusion space
s_TMRgFUS_t1wAparc

% Extract regions of interest from freesurfer brain region labels for
% tractography
s_TMRgFUS_t1wRoi

% Perform diffusion tractography
s_TMRgFUS_diffTrack

% Normalize the number of streamlines from voxel of the seed region
s_TMRgFUS_diffNormSeed

% Compute stats
s_TMRgFUS_diffStats




