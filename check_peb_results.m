cd '/projects/pbic1036/sara/bids_m1_data/derivatives/analysis/DCM'
load('GCM_estimated.mat')

cd '/projects/pbic1036/sara/bids_m1_data/derivatives/analysis/PEB'
load('PEBgroup_foot_vs_lung.mat');

spm_dcm_peb_review(PEB_group,GCM);