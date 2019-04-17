%% BIDS Creator
% initialisation
clearvars
clc

% initalise SPM
spm('Defaults','fMRI');
spm_jobman('initcfg');

%% Define Key Parameters
% define number of volumes per run
n_volumes   = 600;  % number of volumes for M1 data (cb = 445)

% define subject labels
subj_label = {
    'c03'
    'c04'
    'c05'
    'c07'
    'c09'
    'c10'
    'c11'
    'c12'
    'c13'
    'c14'
    'c15'
    'c16'
    'c17'
    'c18'
    'c19'
    'c20'
    'c21'
    'c22'
    'c23'
    'c24'
    'c25'
    'c26' 
};

% define participant numbers
subj_num = [03 04 05 07 09 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26]; % <- list participant number for each label above


% define original data directory  
orig_dir = ''; % directory with old structure
new_dir = ''; % directory where to put new files

%% Create Dataset Description
cd(new_dir)  % directory where to put json file and table with participants

mri_json_name = 'dataset_description.json';

mri_json.Name               = 'tDCS_during_Resting_State';       % <- PROJECT NAME HERE
mri_json.BIDSVersion        = '1.1.1';
mri_json.License            = 'PDDL';
mri_json.Authors            = {'Sara Calzolari' 'Davinia Fernandez-Espejo'};     % <- YOUR NAME HERE
mri_json.HowToAcknowledge   = '';       % <- A REFERENCE/DOI HERE
mri_json.Funding            = '';       % <- FUNDING HERE
mri_json.ReferencesAndLinks = {'https://www.daviniafernandezespejo.com/'};     % <- FURTHER LINKS (e.g. lab website)
json_options.indent                     = '    ';
jsonSaveDir = fileparts(mri_json_name);
jsonwrite(mri_json_name,mri_json,json_options)

%% Create Participants Table
participants_tsv_name = 'participants.tsv';

participant_id         = {'sub-03';'sub-04';'sub-05';'sub-07';'sub-09';'sub-10';'sub-11';'sub-12';'sub-13';'sub-14';'sub-15';'sub-16';'sub-17';'sub-18';'sub-19';'sub-20';'sub-21';'sub-22';'sub-23';'sub-24';'sub-25';'sub-26'};
age                    = [28; 21; 19; 24; 18; 19; 23; 20; 23; 20; 18; 20; 22; 30; 25; 22; 18; 19; 20; 21; 32; 24];
sex                    = {'male'; 'female'; 'male'; 'male'; 'female'; 'female'; 'female'; 'female'; 'male'; 'female'; 'female'; 'female'; 'male'; 'male'; 'male'; 'female'; 'female'; 'female'; 'male'; 'female'; 'female'; 'female'};
edinburgh_handedness   = [100; 100; 69; 100; 70; 40; 82; 71; 100; 66; 100; 100; 100; 100; 100; 100; 70; 100; 42; 100; 100; 100];

t = table(participant_id,age,sex,edinburgh_handedness);

writetable(t,participants_tsv_name,'FileType','text','Delimiter','\t');

%% Move Data
% cycle through subjects of interest
for i = 1:numel(subj_num)
    
    % make new subject directory
    subj_handle = sprintf('sub-%02.0f',subj_num(i));
    subj_dir = [new_dir,'/',subj_handle]; 
    mkdir(subj_dir)
    
    for k = 1:3
        
        %define which session to take
        sessiondir = dir(sprintf('%s%s',orig_dir,'/',subj_label{i}));
        alldirs = sessiondir([sessiondir.isdir]);
        sessions = alldirs(3:end);
        ses_name = sprintf('%s', sessions(k).name);
        old_ses_dir = sprintf('%s%s', orig_dir,'/',subj_label{i},'/',ses_name);
        
        %make new session directory
        ses_ = sprintf('ses-%02.0f',k);
        ses_handle = sprintf('%s', ses_, '-',ses_name(4:length(ses_name)));
        ses_dir = [subj_dir,'/', ses_handle];
        mkdir(ses_dir)
        cd(ses_dir)
        mkdir func
        mkdir anat
        
        
        %% Convert 3D Nifti to 4D, then move Functional Data
        % get all scan names for this run
%         for j = 1 : n_volumes
%             matlabbatch{1}.spm.util.cat.vols{i,1} = cellstr(spm_select('FPList',sprintf('%s/fmri', old_ses_dir),'.nii*'));
%         end
%         
%         
%         % define output 4D file name
%         matlabbatch{1}.spm.util.cat.name = [ses_dir,'/func/',subj_handle,'_',ses_handle,'_rs_during_tDCS','_bold.nii'];
%         matlabbatch{1}.spm.util.cat.dtype = 4;
%         
%         % run batch to convert 3D non-BIDS data to 4D BIDS
%         spm_jobman('run',matlabbatch)
%         clear matlabbatch
%         
%         % delete the created mat file
%         delete([ses_dir,'/func/',subj_handle,'_',ses_handle,'_rs_during_tDCS','_bold.mat'])
        
        %% Create Sidecar JSon Document
        mri_json_name = [ses_dir,'/func/',subj_handle,'_',ses_handle,'_rs_during_tDCS','_bold.json'];
        
        mri_json.TaskName                           = 'rest_during_M1_tDCS_20min';
        mri_json.InstitutionName                    = 'University of Birmingham';
        mri_json.InstitutionAddress                 = 'University of Birmingham, Edgbaston, Birmingham, West Midlands, United Kingdom, B15 2TT';
        mri_json.Manufacturer                       = 'Philips';
        mri_json.ManufacturersModelName             = '3T Philips Achieva MRI Scanner';
        mri_json.Modality                           = 'MR';
        mri_json.MagneticFieldStrength              = '3T';
        mri_json.DeviceSerialNumber                 = '17117';
        mri_json.StationName                        = 'PHILIPS-PB7FMRS';
        mri_json.BodyPartExamined                   = 'BRAIN';
        mri_json.PatientPosition                    = 'HFS';
        mri_json.ProcedureStepDescription           = '2016-247';
        mri_json.SoftwareVersion                    = '5.3.0_5.3.0.3';
        mri_json.MRAcquisitionType                  = '2D';
        mri_json.SeriesDescription                  = '3iso_2s_20min';
        mri_json.ProtocolName                       = 'WIP_3iso_2s_20min';
        mri_json.ScanningSequence                   = 'GR';
        mri_json.SequenceVariant                    = 'SK';
        mri_json.ScanOptions                        = 'FS';
        mri_json.ImageType                          = ['ORIGINAL' 'PRIMARY' 'M' 'FFE' 'M' 'FFE'];
	    mri_json.SeriesNumber                       = 701;
	    mri_json.AcquisitionTime                    = 11:18:39.680000;
	    mri_json.AcquisitionNumber                  =7;
	    mri_json.PhilipsRescaleSlope                = 0.773382;
	    mri_json.PhilipsRescaleIntercept            = 0;
	    mri_json.PhilipsScaleSlope                  = 0.000341801;
	    mri_json.UsePhilipsFloatNotDisplayScaling   = 1;
	    mri_json.SliceThickness                     = 3;
	    mri_json.SpacingBetweenSlices               = 3;
        mri_json.RepetitionTime                     = 2;
        mri_json.EchoTime                           = 0.0345;
        mri_json.FlipAngle                          =  79.09999985;
        mri_json.VolumeTiming                       = (0:n_volumes-1) * 2;
        mri_json.NumberOfVolumesDiscardedByScanner  = 2;
        mri_json.NumberOfVolumesDiscardedByUser     = 0;
        mri_json.VoxelSize                          = [3 3 3];
        mri_json.Slices                             = 34;
        mri_json.PercentPhaseFOV                    = 100;
	    mri_json.EchoTrainLength                    = 43;
	    mri_json.PhaseEncodingSteps                 = 80;
	    mri_json.AcquisitionMatrixPE                = 80;
	    mri_json.ReconMatrixPE                      = 80;
	    mri_json.PixelBandwidth                     = 2420.37;
        mri_json.ImageOrientationPatientDICOM       = [0.999557
            -1.25212e-10
            -0.0297452
            -0.00825085
            0.960759
            -0.277262  ];
        
        json_options.indent                         = '    '; % this makes the json look pretier when opened in a txt editor
        
        jsonwrite(mri_json_name,mri_json,json_options)
    
    
  %% Move Structural Data
    % copy file
    copyfile([ls(fullfile(old_ses_dir,'/T1/','*.nii'))],...
        [ses_dir,'/anat/',subj_handle,'_T1w.nii'])
    
    %% Move Functional Data (if no 3D to 4D conversion)
    % copy file
      copyfile([ls(fullfile(old_ses_dir,'/fmri/','*.nii'))],...
        [ses_dir,'/func/',subj_handle,'_',ses_handle,'_rs_during_tDCS.nii'])
    
   end 
end
    