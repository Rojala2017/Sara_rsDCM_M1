%% with DAVINIA

P = spm_get(inf,'*.nii','Select images');
% roi1 = cellstr(spm_select('FPList','PCu_roi.mat'));
mY= get_marsy(roi,P,'mean');
y = summary_data(mY);
y
save PCutimecourse300 y

%% from MarsBaR
roi_files = spm_get(Inf,'PCu_roi.mat', 'Select ROI files');
P = spm_get(inf,'*.nii','Select images');
rois = maroi('load_cell', roi_files);
mY = get_marsy(rois{:},P,'mean');
y = summary_data(mY);
save PCutimecourse600NEW y


% rois = spm_hold(rois, 0);
% saveroi(rois, 'PCu_roi1.mat');

%%
% Output argument "vXYZ" (and maybe others) not assigned during call to
% "maroi/getdata".
% 
% Error in maroi/get_marsy (line 76)
%   [y vals vXYZ mat]  = getdata(o, VY);
%  
% rois = spm_hold(rois, 0);
% Undefined function 'spm_hold' for input arguments of type 'cell'.

%% from Sean's script
path = '/projects/pbic1036/sara/bids_m1_data/derivatives/preprocessing/'; %path to my dataset
participants = {'sub-03/ses-01lung/func/temp_filt_func_conn_test'};

roi1 = cellstr(spm_select('FPList',sprintf('%s/',path,participants{1}),'PCu_roi.mat'));
P = spm_select('FPList',sprintf('%s/',path,participants{1}),'.nii*');
  
rois = maroi('load_cell',roi1); % make maroi ROI objects
mY = get_marsy(rois{:},P,'mean'); %extract data into marsy data
y = summary_data(mY);
 
save(fullfile(thisparticipantpath,'temp_filt_CONN_check.mat'));
 
 