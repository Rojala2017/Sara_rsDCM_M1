% code to run maxmov_rel in a batch
% Sara Calzolari 03/2019
nrun = 65; % enter the number of sessions here 
path = '/projects/pbic1036/sara/bids_m1_data/derivatives/preprocessing'; 

participants = {'sub-03/ses-01lung'
    'sub-03/ses-02foot'
    'sub-03/ses-03back'
%   'sub-04/ses-01lung' was not preprocessed, has less volumes (370/600)
    'sub-04/ses-02back'
    'sub-04/ses-03foot'
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


% set up your thresholds here
dist = 2; % this is the distance for the translation in mm
ang = 0.035; % this is the angle for the rotation in radians 

for crun = 1:nrun
    thisparticipantpath=sprintf('%s%s',path,'/',participants{crun}); 
    filename=spm_select('FPList',sprintf('%s/func',thisparticipantpath),'rp_*');
    amatrix=load(filename);
   % raw values
    x=amatrix(:,1);
    y=amatrix(:,2);
    z=amatrix(:,3);
    pitch=amatrix(:,4);
    roll=amatrix(:,5);
    yaw=amatrix(:,6);
    
    % relative distances
    tx=diff(x);
    ty=diff(y);
    tz=diff(z);
    rpitch=diff(pitch);
    rroll=diff(roll);
    ryaw=diff(yaw);
    
    % which ones are above thresold. Note that you have to add 1 position
    % to obtain the right number for the volume. These are the values you
    % need to look at in your report so you can see which volumes to remove
    
    transx=(find(abs(tx)>dist))+1;
    transy=(find(abs(ty)>dist))+1;
    transz=(find(abs(tz)>dist))+1;
    rot_pitch=(find(abs(rpitch)>ang))+1;
    rot_roll=(find(abs(rroll)>ang))+1;
    rot_yaw=(find(abs(ryaw)>ang))+1;
    
    % save everything 
    save(fullfile(thisparticipantpath,'maxmov_rel_report.mat')); 
end
