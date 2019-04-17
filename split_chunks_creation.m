% List of open inputs
% Change Directory: Directory - cfg_files
% 4D to 3D File Conversion: 4D Volume - cfg_files
nrun = 65; % enter the number of runs here
path =  '/projects/pbic1036/sara/bids_m1_data/derivatives/preprocessing';  % path to my dataset


jobfile = {'/projects/pbic1036/script_sara/split_chunks_creation_job.m'};
jobs = repmat(jobfile, 1, nrun);
inputs = cell(2, nrun);


participants = {'sub-03/ses-01lung/func'
    'sub-03/ses-02foot/func'
    'sub-03/ses-03back/func'
%   'sub-04/ses-01lung/func'
    'sub-04/ses-02back/func'
    'sub-04/ses-03foot/func'
    'sub-05/ses-01foot/func'
    'sub-05/ses-02back/func'
    'sub-05/ses-03lung/func'
    'sub-07/ses-01foot/func'
    'sub-07/ses-02lung/func'
    'sub-07/ses-03back/func'
    'sub-09/ses-01back/func'
    'sub-09/ses-02foot/func'
    'sub-09/ses-03lung/func'
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
    'sub-14/ses-01back/func'
    'sub-14/ses-02lung/func'
    'sub-14/ses-03foot/func'
    'sub-15/ses-01foot/func'
    'sub-15/ses-02lung/func'
    'sub-15/ses-03back/func'
    'sub-16/ses-01back/func'
    'sub-16/ses-02lung/func'
    'sub-16/ses-03foot/func'
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
    'sub-24/ses-03back/func'
    'sub-25/ses-01back/func'
    'sub-25/ses-02foot/func'
    'sub-25/ses-03lung/func'
    'sub-26/ses-01lung/func'
    'sub-26/ses-02back/func'
    'sub-26/ses-03foot/func'
    };

for crun = 1:nrun
    thisparticipant = sprintf('%s%s', path,'/',participants{crun});
    inputs{1, crun} = {thisparticipant}; % Change Directory: Directory - cfg_files
    inputs{2, crun} = cellstr(spm_select('FPList',sprintf('%s/',thisparticipant),'temporal_filtered_func_data.nii')); % 4D to 3D File Conversion: 4D Volume - cfg_files
end
spm('defaults', 'FMRI');
spm_jobman('run', jobs, inputs{:});
