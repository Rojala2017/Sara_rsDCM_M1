% CODE TO FIND PARTICIPANTS (AND VOLUMES) WITH EXCESSIVE MOTION
% To be used after maxmov_rel.m 
% Sara Calzolari 06/03/2019

nrun = 65; % enter the number of sessions here
path = '/projects/pbic1036/sara/bids_m1_data/derivatives/preprocessing';
cd(path)

mytable = cell(nrun,7);
varnames = {'participant_session'; 'transx';'transy';'transz';'rot_pitch';'rot_roll';'rot_yaw'};

fid = fopen('discard_participants.txt', 'wt');

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


for crun = 1:nrun
    mytable{crun,1} = participants(crun);
    thisparticipantpath=sprintf('%s%s',path,'/',participants{crun});
    filename=spm_select('FPList',sprintf('%s',thisparticipantpath),'maxmov_rel_report.mat');
    amatrix=load(filename);
    
    % maxmov_rel_report.mat contains info on which volumes to remove
    
    % fill mytable with excessive motion volumes (when applicalble)
    
    % transx
    if isempty(amatrix.transx)
        mytable{crun,2} = {'none'};
    else
        mytable{crun,2} = {amatrix.transx};
    end
    
    % transy
    if isempty(amatrix.transy)
        mytable{crun,3} = {'none'};
    else
        mytable{crun,3} = {amatrix.transy};
    end
    
    % transz
    if isempty(amatrix.transz)
        mytable{crun,4} = {'none'};
    else
        mytable{crun,4} = {amatrix.transz};
    end
    
    % rot_pitch
    if isempty(amatrix.rot_pitch)
        mytable{crun,5} = {'none'};
    else
        mytable{crun,5} = {amatrix.rot_pitch};
    end
    
    % rot_roll
    if isempty(amatrix.rot_roll)
        mytable{crun,6} = {'none'};
    else
        mytable{crun,6} = {amatrix.rot_roll};
    end
    
    % rot_yaw
    if isempty(amatrix.rot_yaw)
        mytable{crun,7} = {'none'};
    else
        mytable{crun,7} = {amatrix.rot_yaw};
    end
    
    if length(amatrix.transx) > 15 || length(amatrix.transy) > 15 || length(amatrix.transz) > 15 ...
            || length(amatrix.rot_pitch) > 15 || length(amatrix.rot_roll) > 15 || length(amatrix.rot_yaw) > 15
        
        fprintf(fid, '%s',participants{crun},' exceeds threshold');
        fprintf(fid, '\n');
    end
end

fid = fclose(fid);

% save as .mat file and .csv table
save('mytable', 'mytable')
T = cell2table(mytable, 'VariableNames', varnames);
%writetable(T, 'output_from_maxmov_rel_report.csv')