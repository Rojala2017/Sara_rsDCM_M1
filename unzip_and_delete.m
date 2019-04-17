nrun = 1; % enter the number of runs here %17
path =  '/projects/pbic1036/sara/bids_m1_data/derivatives/preprocessing';  % path to my dataset

participants = {
%     'sub-03/ses-01lung'
%     'sub-03/ses-02foot'
%     'sub-03/ses-03back'
% %   'sub-04/ses-01lung' has less volumes
%     'sub-04/ses-02back'
%     'sub-04/ses-03foot'
%     'sub-05/ses-01foot'
%     'sub-05/ses-02back'
%     'sub-05/ses-03lung'
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
    'sub-21/ses-02foot'
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
%     'sub-26/ses-01lung'
%     'sub-26/ses-02back'
%     'sub-26/ses-03foot'
    };

for crun = 1:nrun
    
    data_dir = sprintf('%s%s', path,'/',participants{crun},'/func');
    cd(data_dir)
    
    % DELETION OF RESIDUALS (for lack of space on disk)
    res_files = dir('Res_*.nii');
    for j = 1:length(res_files)
    current =  res_files(j).name;
    delete(current)
    end
    
    gunzip temporal_filtered_func_data.nii.gz
    delete temporal_filtered_func_data.nii.gz
    
end