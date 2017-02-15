# TractographyMRgFUS

Codes of the analysis pipeline for using diffusion MRI tractography for transcranial MRI-guided focused ultrasound thalamotomy targeting.

Requirements

Install the softwares listed below:

[1] MATLAB, https://www.mathworks.com/

[2] FMRIB Software Library (FSL) v5.0.9, http://fsl.fmrib.ox.ac.uk/fsl/fslwiki/FslInstallation

[3] FreeSurfer v5.3.0, https://surfer.nmr.mgh.harvard.edu/fswiki/DownloadAndInstall

Example Data

A single subject data (100307) from the WU-UMinn Human Connectome Project (https://www.humanconnectome.org/) was downloaded and modified to provide example data to demonstrate the analysis pipeline. 

For diffusion data, b=0 iamges and b=2000 diffusion weighted images were extracted to mimic pre-treatment diffusion data for tractography. 

For strucrual data, both T1-weighted and T2-weighted images were extracted to mimic post-treatment structural data for delineating MRgFUS induced lesion. 

A make-up lesion location was created for demonstration purpose only. 

References

Please cite the references below if you are using the codes:

[1] Tian Q, Wintermark M, Pauly KB, Huss D, Elias WJ, McNab JA. Diffusion MRI Tractography for Improved MRI-guided Focused Ultrasound Thalamotomy Targeting for Essential TremorIn Proceedings of the 24th Annual Meeting of the International Society for Magnetic Resonance in Medicine (ISMRM), Singapore, May 2016; Abstract 0823.

(c) Qiyuan Tian, McNab Lab, Stanford University

2017 February
