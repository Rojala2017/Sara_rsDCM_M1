% List of open inputs
% Change Directory: Directory - cfg_files
% fMRI model specification: Directory - cfg_files
% fMRI model specification: Scans - cfg_files
% fMRI model specification: Multiple regressors - cfg_files

% SARA
% This script runs a GLM for each subject/session
% Regressors for motion are included because this is just for
% participants who showed VOLUMES WITH EXCESSIVE MOVEMENTS

nrun = 1; %11; % enter the number of runs here
path =  '/projects/pbic1036/sara/bids_m1_data/derivatives/preprocessing';  % path to my dataset

jobfile = {'/projects/pbic1036/script_sara/glm/sara_INF_single_REGRESSORS_job.m'};
jobs = repmat(jobfile, 1, nrun);
inputs = cell(4, nrun);

participants = {
%     'sub-03/ses-01lung'
%     'sub-03/ses-02foot'
      'sub-03/ses-03back'
% %   'sub-04/ses-01lung' has less volumes
%       'sub-04/ses-02back'
% %     'sub-04/ses-03foot'
% %     'sub-05/ses-01foot'
% %     'sub-05/ses-02back'
% %     'sub-05/ses-03lung'
% %     'sub-07/ses-01foot'
% %     'sub-07/ses-02lung'
% %     'sub-07/ses-03back'
% %     'sub-09/ses-01back'
% %     'sub-09/ses-02foot'
%       'sub-09/ses-03lung'
% %     'sub-10/ses-01back'
% %     'sub-10/ses-02lung'
% %     'sub-10/ses-03foot'
% %     'sub-11/ses-01lung'
% %     'sub-11/ses-02foot'
% %     'sub-11/ses-03back'
% %     'sub-12/ses-01lung'
% %     'sub-12/ses-02back'
% %     'sub-12/ses-03foot'
% %     'sub-13/ses-01lung'
% %     'sub-13/ses-02back'
% %     'sub-13/ses-03foot'
%       'sub-14/ses-01back'
%       'sub-14/ses-02lung'
%       'sub-14/ses-03foot'
% %     'sub-15/ses-01foot'
% %     'sub-15/ses-02lung'
% %     'sub-15/ses-03back'
%       'sub-16/ses-01back'
%       'sub-16/ses-02lung'
%       'sub-16/ses-03foot'
% %     'sub-17/ses-01lung'
% %     'sub-17/ses-02back'
% %     'sub-17/ses-03foot'
% %     'sub-18/ses-01lung'
% %     'sub-18/ses-02foot'
% %     'sub-18/ses-03back'
% %     'sub-19/ses-01foot'
% %     'sub-19/ses-02back'
% %     'sub-19/ses-03lung'
% %     'sub-20/ses-01back'
% %     'sub-20/ses-02lung'
% %     'sub-20/ses-03foot'
% %     'sub-21/ses-01back'
% %     'sub-21/ses-02foot'
% %     'sub-21/ses-03lung'
% %     'sub-22/ses-01foot'
% %     'sub-22/ses-02lung'
% %     'sub-22/ses-03back'
% %     'sub-23/ses-01lung'
% %     'sub-23/ses-02back'
% %     'sub-23/ses-03foot'
% %     'sub-24/ses-01lung'
% %     'sub-24/ses-02foot'
%       'sub-24/ses-03back'
%       'sub-25/ses-01back'
% %     'sub-25/ses-02foot'
% %     'sub-25/ses-03lung'
% %     'sub-26/ses-01lung'
% %     'sub-26/ses-02back'
%       'sub-26/ses-03foot'
    };



for crun = 1:nrun
    
    thisparticipant = sprintf('%s%s', path,'/',participants{crun});
%     cd(thisparticipant)
%     regressor = load('volumes_regressor_matrix.mat');
    
    
    inputs{1, crun} = {thisparticipant}; % Change Directory: Directory - cfg_files
    
    glm = '/projects/pbic1036/sara/bids_m1_data/derivatives/analysis/1st_level_glm';
    cd(glm)
    
    subj_handle = participants{crun}(1:6);
    
    % make new subj directory if it doesn't exist already
    if ~exist(subj_handle)
    mkdir(subj_handle)
    end

    cd(subj_handle)
    
    % make new session directory
    ses_handle = participants{crun}(8:17);
    mkdir(ses_handle)
    
    new_dir = sprintf('%s',glm,'/',subj_handle,'/',ses_handle);

    
    inputs{2, crun} = {new_dir}; % fMRI model specification: Directory - cfg_files
    inputs{3, crun} = cellstr(spm_select('FPList',sprintf('%s/func/',thisparticipant),'snoise_filtered.nii')); % fMRI model specification: Scans - cfg_files
    inputs{4, crun} = cellstr(spm_select('FPList',sprintf('%s/',thisparticipant),'volumes_regressor_matrix.mat')); % fMRI model specification: Multiple regressors - cfg_files
end
spm('defaults', 'FMRI');
spm_jobman('run', jobs, inputs{:});
