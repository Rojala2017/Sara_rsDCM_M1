start_time = clock;

dcm_dir = '/projects/pbic1036/sara/bids_m1_data/derivatives/analysis/1st_level_glm/'; % Change this to where your DCMs are located

participants = {
    'sub-03/ses-01lung'
    'sub-03/ses-02foot'
    'sub-03/ses-03back'
    'sub-05/ses-01foot'
    'sub-05/ses-02back'
    'sub-05/ses-03lung'
    'sub-07/ses-01foot'
    'sub-07/ses-02lung'
    'sub-07/ses-03back'
    'sub-09/ses-01back'
    'sub-09/ses-02foot'
    'sub-09/ses-03lung'
    'sub-10/ses-01back'
    'sub-10/ses-02lung'
    'sub-10/ses-03foot'
    'sub-11/ses-01lung'
    'sub-11/ses-02foot'
    'sub-11/ses-03back'
    'sub-12/ses-01lung'
    'sub-12/ses-02back'
    'sub-12/ses-03foot'
    'sub-13/ses-01lung'
    'sub-13/ses-02back'
    'sub-13/ses-03foot'
    'sub-14/ses-01back'
    'sub-14/ses-02lung'
    'sub-14/ses-03foot'
    'sub-15/ses-01foot'
    'sub-15/ses-02lung'
    'sub-15/ses-03back'
    'sub-16/ses-01back'
    'sub-16/ses-02lung'
    'sub-16/ses-03foot'
    'sub-17/ses-01lung'
    'sub-17/ses-02back'
    'sub-17/ses-03foot'
    'sub-18/ses-01lung'
    'sub-18/ses-02foot'
    'sub-18/ses-03back'
    'sub-19/ses-01foot'
    'sub-19/ses-02back'
    'sub-19/ses-03lung'
    'sub-20/ses-01back'
    'sub-20/ses-02lung'
    'sub-20/ses-03foot'
    'sub-21/ses-01back'
    'sub-21/ses-02foot'
    'sub-21/ses-03lung'
    'sub-22/ses-01foot'
    'sub-22/ses-02lung'
    'sub-22/ses-03back'
    'sub-23/ses-01lung'
    'sub-23/ses-02back'
    'sub-23/ses-03foot'
    'sub-24/ses-01lung'
    'sub-24/ses-02foot'
    'sub-24/ses-03back'
    'sub-25/ses-01back'
    'sub-25/ses-02foot'
    'sub-25/ses-03lung'
    'sub-26/ses-01lung'
    'sub-26/ses-02back'
    'sub-26/ses-03foot'
    };


% Identify all DCMs
% P = cellstr(spm_select('FPList',dcm_dir,'^sub.*mat$'));

P = {};
for n = 1:length(participants)
    thisparticipant = sprintf('%s',dcm_dir,participants{n});
current = cellstr(spm_select('FPList',thisparticipant,'DCM_motor_new.mat'));
current = char(current);
P{n,1} = current;
end

% Load
GCM = spm_dcm_load(P);

for i = 1:length(P)    
    % Fix the B matrix to have an empty 3rd dimension
    GCM{i}.b = zeros(4,4,0);
end

% Estimate
GCM = spm_dcm_peb_fit(GCM,[],{'A'});

% Save

outputdir = '/projects/pbic1036/sara/bids_m1_data/derivatives/analysis/DCM';
cd(outputdir)

end_time = clock;

save('GCM_estimated_try.mat', 'GCM');