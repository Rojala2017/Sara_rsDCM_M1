%% Specify DCM in multiple subjects
%you need to copy the template files in the directory of each subject
%first as this script will overwrite them
nrun = 63; % enter the number of runs here
path = '/projects/pbic1036/sara/bids_m1_data/derivatives/analysis/1st_level_glm/';

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


% pathcount = 1;
% 
% for p = 1:length(participants)
%     for s = 1:length(sessions)
%         for sr = 1:length(series)            
%             d = dir(fullfile(path,participants{p},sessions{s}));            
%             d = d(d.isdir);
%             allparticipantpaths{pathcount} = fullfile(path,participants{p},d.name,series{sr});
%             pathcount = pathcount+1;
%         end
%     end
% end

for crun = 1:nrun
  thisparticipantpath = sprintf('%s%s',path, participants{crun});  

 % DCM_model = sprintf('%s%s',thisparticipantpath, '/glm_hpf_rp/DCM_fully_connected_3regions_indiv.mat'); % in this study I only have 1 but this could be expanded to include more than one model
  DCM_model = sprintf('%s%s',thisparticipantpath,'/', 'DCM_motor_new.mat'); 
%   spm_dcm_voi (fullfile(DCM_model), {(fullfile(thisparticipantpath,'glm_hpf_rp','VOI_M1_fixed_1.mat')), (fullfile(thisparticipantpath,'glm_hpf_rp','VOI_SMA_fixed_1.mat')), (fullfile(thisparticipantpath,'glm_hpf_rp','VOI_LTh_fixed_1.mat')), (fullfile(thisparticipantpath,'glm_hpf_rp','VOI_Rcerebellum_fixed_1.mat'))});
%   spm_dcm_voi (fullfile(DCM_model), {(fullfile(thisparticipantpath,'glm_hpf_rp','VOI_M1_fixed_1.mat')), (fullfile(thisparticipantpath,'glm_hpf_rp','VOI_SMA_fixed_1.mat')), (fullfile(thisparticipantpath,'glm_hpf_rp','VOI_LTh_fixed_1.mat'))});

    spm_dcm_voi (fullfile(DCM_model), {(fullfile(thisparticipantpath,'/VOI_M1_indiv_1.mat')), (fullfile(thisparticipantpath,'/VOI_SMA_indiv_1.mat')), (fullfile(thisparticipantpath,'/VOI_LTh_indiv_1.mat')), (fullfile(thisparticipantpath,'/VOI_Rcerebellum_indiv_1.mat'))});
%     spm_dcm_voi (fullfile(DCM_model), {(fullfile(thisparticipantpath,'glm_hpf_rp','VOI_M1_indiv_1.mat')), (fullfile(thisparticipantpath,'glm_hpf_rp','VOI_SMA_indiv_1.mat')), (fullfile(thisparticipantpath,'glm_hpf_rp','VOI_LTh_indiv_1.mat'))});
  
 
end