% List of open inputs
% Change Directory: Directory - cfg_files
% Realign: Estimate & Reslice: Session - cfg_files
% Coregister: Estimate: Source Image - cfg_files
% fMRI model specification: Directory - cfg_files

%% NOTES:

%  (Sara) The raw data I input here have been manually realigned by me (and
%         checked by Davinia)

%  (Sara) Participant 04 - session 01 has less volumes (370 instead of
%         600), so it won't be preprocessed now (maybe later, individually)

%  (Sara) SLICE TIMING: this module doesn't accept 4D niftis, so I added 4D
%         to 3D conversion before that step and 3D to 4D conversion afterwards

%  (Sara) DENOISING (3 PCs): physiological + motion regressors with 0.95 threshold
%                    and cropping 1 voxel from wc2 and wc3 masks

%  (Sara) GLM model specification: microtime resolution and onset have been
%         set as N.Slices and N.Slices/2

%%

nrun = 11; % enter the number of runs here
path =  '/projects/pbic1036/sara/bids_m1_data/derivatives/preprocessing';  % path to my dataset

jobfile = {'/projects/pbic1036/script_sara/preprocessing/PREPROCESSING_motion_095threshold_job.m'};
jobs = repmat(jobfile, 1, nrun);
inputs = cell(4, nrun);

%%

participants = {
    'sub-03/ses-01lung'
    'sub-03/ses-02foot'
    'sub-03/ses-03back'
%   % 'sub-04/ses-01lung'  %  less volumes due to scanning problems
    'sub-04/ses-02back'
    'sub-04/ses-03foot'
    'sub-05/ses-01foot'
    'sub-05/ses-02back'
    'sub-05/ses-03lung'
%     'sub-07/ses-01foot'
%     'sub-07/ses-02lung'
%     'sub-07/ses-03back'
%     'sub-09/ses-01back'
%     'sub-09/ses-02foot'
%     'sub-09/ses-03lung'
%     'sub-10/ses-01back'
%     'sub-10/ses-02lung'
%     'sub-10/ses-03foot'
%     'sub-11/ses-01lung'
%     'sub-11/ses-02foot'
%     'sub-11/ses-03back'
%     'sub-12/ses-01lung'
%     'sub-12/ses-02back'
%     'sub-12/ses-03foot'
%     'sub-13/ses-01lung'
%     'sub-13/ses-02back'
%     'sub-13/ses-03foot'
%     'sub-14/ses-01back'
%     'sub-14/ses-02lung'
%     'sub-14/ses-03foot'
%     'sub-15/ses-01foot'
%     'sub-15/ses-02lung'
%     'sub-15/ses-03back'
%     'sub-16/ses-01back'
%     'sub-16/ses-02lung'
%     'sub-16/ses-03foot'
%     'sub-17/ses-01lung'
%     'sub-17/ses-02back'
%     'sub-17/ses-03foot'
%     'sub-18/ses-01lung'
%     'sub-18/ses-02foot'
%     'sub-18/ses-03back'
%     'sub-19/ses-01foot'
%     'sub-19/ses-02back'
%     'sub-19/ses-03lung'
%     'sub-20/ses-01back'
%     'sub-20/ses-02lung'
%     'sub-20/ses-03foot'
%     'sub-21/ses-01back'
%     'sub-21/ses-02foot'
%     'sub-21/ses-03lung'
%     'sub-22/ses-01foot'
%     'sub-22/ses-02lung'
%     'sub-22/ses-03back'
%     'sub-23/ses-01lung'
%     'sub-23/ses-02back'
%     'sub-23/ses-03foot'
%     'sub-24/ses-01lung'
%     'sub-24/ses-02foot'
%     'sub-24/ses-03back'
%     'sub-25/ses-01back'
%     'sub-25/ses-02foot'
%     'sub-25/ses-03lung'
    'sub-26/ses-01lung'
    'sub-26/ses-02back'
    'sub-26/ses-03foot'
    };

%%

for crun = 1:nrun
    
    thisparticipant = sprintf('%s%s', path,'/',participants{crun});
    fmripath = sprintf('%s%s',thisparticipant,'/func');
    
    inputs{1, crun} = {thisparticipant}; % Change Directory: Directory - cfg_files
    inputs{2, crun} = cellstr(spm_select('FPList',sprintf('%s/func/',thisparticipant),'.nii*')); % Realign: Estimate & Reslice: Session - cfg_files
    inputs{3, crun} = cellstr(spm_select('FPList',sprintf('%s/anat/',thisparticipant),'.nii*')); % Coregister: Estimate: Source Image - cfg_files
    inputs{4, crun} = {fmripath}; % fMRI model specification: Directory - cfg_files
end

spm('defaults', 'FMRI');
spm_jobman('run', jobs, inputs{:});
