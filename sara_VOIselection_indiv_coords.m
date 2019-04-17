% List of open inputs
% Change Directory: Directory - cfg_files
% Volume of Interest: Select SPM.mat - cfg_files
% Volume of Interest: Centre - cfg_entry
% Volume of Interest: Select SPM.mat - cfg_files
% Volume of Interest: Centre - cfg_entry
% Volume of Interest: Select SPM.mat - cfg_files
% Volume of Interest: Centre - cfg_entry
% Volume of Interest: Select SPM.mat - cfg_files
% Volume of Interest: Centre - cfg_entry

nsub = 21;
nses = 3;
nrun = nsub*nses; % enter the number of runs here
path =  '/projects/pbic1036/sara/bids_m1_data/derivatives/analysis/1st_level_glm';  % path to my dataset

jobfile = {'/projects/pbic1036/script_sara/DCM/sara_VOIselection_indiv_coords_job.m'};
jobs = repmat(jobfile, 1, nrun);
inputs = cell(9, nrun);

%% files with coordinates
% Lth = load('/projects/pbic1036/coordinates4Sara/DCM2_coordinates_Lth_combined.mat');
% M1  = load('/projects/pbic1036/coordinates4Sara/DCM2_coordinates_M1_combined.mat');
% Rcereb = load('/projects/pbic1036/coordinates4Sara/DCM2_coordinates_Rcer_combined.mat');
% SMA = load('/projects/pbic1036/coordinates4Sara/DCM2_coordinates_SMA.mat');

%% participants

participants = {'sub-03'
%   'sub-04'  %  will be done separately if needed
    'sub-05'
    'sub-07'
    'sub-09'
    'sub-10'
    'sub-11'
    'sub-12'
    'sub-13'
    'sub-14'
    'sub-15'
    'sub-16'
    'sub-17'
    'sub-18'
    'sub-19'
    'sub-20'
    'sub-21'
    'sub-22'
    'sub-23'
    'sub-24'
    'sub-25'
    'sub-26'
    };

%%
ntot = 1;
for crun = 1:nsub
    thisparticipant = sprintf('%s%s', path,'/',participants{crun});
    sessiondir = dir(thisparticipant);
    alldirs = sessiondir([sessiondir.isdir]);
    sessions = alldirs(3:end);
    
    for srun = 1:nses
        
        thissessionpath = sprintf('%s%s', path, '/', participants{crun}, '/', sessions(srun).name);
        this_Lth = Lth.Lth_combined(:,crun);
        this_M1 = M1.M1_combined(:,crun);
        this_Rcer = Rcereb.Rcer_combined(:,crun);
        this_SMA = SMA.coordinates(:,crun);
        
        inputs{1, ntot} = {thissessionpath}; % Change Directory: Directory - cfg_files
        inputs{2, ntot} = {fullfile(thissessionpath,'SPM.mat')}; % Volume of Interest: Select SPM.mat - cfg_files
        inputs{3, ntot} = this_SMA; % Volume of Interest: Centre - cfg_entry
        inputs{4, ntot} = {fullfile(thissessionpath,'SPM.mat')}; % Volume of Interest: Select SPM.mat - cfg_files
        inputs{5, ntot} = this_M1; % Volume of Interest: Centre - cfg_entry
        inputs{6, ntot} = {fullfile(thissessionpath,'SPM.mat')}; % Volume of Interest: Select SPM.mat - cfg_files
        inputs{7, ntot} = this_Lth; % Volume of Interest: Centre - cfg_entry
        inputs{8, ntot} = {fullfile(thissessionpath,'SPM.mat')}; % Volume of Interest: Select SPM.mat - cfg_files
        inputs{9, ntot} = this_Rcer; % Volume of Interest: Centre - cfg_entry
      
        ntot = ntot+1;
    end
end
spm('defaults', 'FMRI');
spm_jobman('run', jobs, inputs{:});
