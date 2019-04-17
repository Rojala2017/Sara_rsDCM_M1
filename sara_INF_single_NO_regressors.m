% List of open inputs
% Change Directory: Directory - cfg_files
% fMRI model specification: Directory - cfg_files
% fMRI model specification: Scans - cfg_files

% SARA
% This script runs a GLM for each subject/session (whole time series)
% NO regressors for motion are included because this is just for
% participants who did NOT show volumes with excessive movement

nrun = 54; % enter the number of runs here
path =  '/projects/pbic1036/sara/bids_m1_data/derivatives/preprocessing';  % path to my dataset

jobfile = {'/projects/pbic1036/script_sara/glm/sara_INF_single_NO_regressors_job.m'};
jobs = repmat(jobfile, 1, nrun);
inputs = cell(3, nrun);

participants = {
    'sub-03/ses-01lung/func'
    'sub-03/ses-02foot/func'
%   'sub-03/ses-03back/func'
%%  'sub-04/ses-01lung/func'
%   'sub-04/ses-02back/func'
    'sub-04/ses-03foot/func'
    'sub-05/ses-01foot/func'
    'sub-05/ses-02back/func'
    'sub-05/ses-03lung/func'
    'sub-07/ses-01foot/func'
    'sub-07/ses-02lung/func'
    'sub-07/ses-03back/func'
    'sub-09/ses-01back/func'
    'sub-09/ses-02foot/func'
%   'sub-09/ses-03lung/func'
    'sub-10/ses-01back/func'
    'sub-10/ses-02lung/func'
    'sub-10/ses-03foot/func'
    'sub-11/ses-01lung/func'
    'sub-11/ses-02foot/func'
    'sub-11/ses-03back/func'
    'sub-12/ses-01lung/func'
    'sub-12/ses-02back/func'
    'sub-12/ses-03foot/func'
    'sub-13/ses-01lung/func'
    'sub-13/ses-02back/func'
    'sub-13/ses-03foot/func'
%   'sub-14/ses-01back/func'
%   'sub-14/ses-02lung/func'
%   'sub-14/ses-03foot/func'
    'sub-15/ses-01foot/func'
    'sub-15/ses-02lung/func'
    'sub-15/ses-03back/func'
%   'sub-16/ses-01back/func'
%   'sub-16/ses-02lung/func'
%   'sub-16/ses-03foot/func'
    'sub-17/ses-01lung/func'
    'sub-17/ses-02back/func'
    'sub-17/ses-03foot/func'
    'sub-18/ses-01lung/func'
    'sub-18/ses-02foot/func'
    'sub-18/ses-03back/func'
    'sub-19/ses-01foot/func'
    'sub-19/ses-02back/func'
    'sub-19/ses-03lung/func'
    'sub-20/ses-01back/func'
    'sub-20/ses-02lung/func'
    'sub-20/ses-03foot/func'
    'sub-21/ses-01back/func'
    'sub-21/ses-02foot/func'
    'sub-21/ses-03lung/func'
    'sub-22/ses-01foot/func'
    'sub-22/ses-02lung/func'
    'sub-22/ses-03back/func'
    'sub-23/ses-01lung/func'
    'sub-23/ses-02back/func'
    'sub-23/ses-03foot/func'
    'sub-24/ses-01lung/func'
    'sub-24/ses-02foot/func'
%   'sub-24/ses-03back/func'
%   'sub-25/ses-01back/func'
    'sub-25/ses-02foot/func'
    'sub-25/ses-03lung/func'
    'sub-26/ses-01lung/func'
    'sub-26/ses-02back/func'
    'sub-26/ses-03foot/func'
      };



for crun = 1:nrun
    
     thisparticipant = sprintf('%s%s', path,'/',participants{crun});
     inputs{1, crun} = {thisparticipant}; % Change Directory: Directory - cfg_files
    
    glm = '/projects/pbic1036/sara/bids_m1_data/derivatives/analysis/1st_level_glm';
    cd(glm)
    
    % make new subject and session directory
    subj_handle = participants{crun}(1:6);
    
    if ~exist(subj_handle)
    mkdir(subj_handle)
    end
    
    cd(subj_handle)
    ses_handle = participants{crun}(8:17);
    mkdir(ses_handle)
    
    new_dir = sprintf('%s',glm,'/',subj_handle,'/',ses_handle);
    
    inputs{2, crun} = {new_dir}; % fMRI model specification: Directory - cfg_files
    inputs{3, crun} = cellstr(spm_select('FPList',sprintf('%s/',thisparticipant),'snoise_filtered.nii')); % fMRI model specification: Scans - cfg_files

end
spm('defaults', 'FMRI');
spm_jobman('run', jobs, inputs{:});
