% CODE TO CREATE A REGRESSOR MATRIX
% FOR EACH SUBJ/SES INCLUDING VOLUMES WITH EXCESSIVE MOTION

% To be used after find_excessive_motion_sara.m
% It calls the cell array "mytable" created by the previous script
% Sara Calzolari 06/03/2019

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


%load table indicating which volumes have excessive motion
filename=spm_select('FPList',sprintf('%s',path),'mytable.mat');
mymatrix=load(filename);
mytable=mymatrix.mytable;


% run through subjects/sessions
for crun = 1:nrun
    
    volumes = double.empty;
    
    
    % run through the columns of the table
    % extract the problematic volumes for each subj/ses
    for i = 1:6  % because column 1 contains participants labels
        
        a = strcmp(mytable{crun,i+1}, 'none');
        if a == 0
            vol = cell2mat(mytable{crun,i+1});
            volumes = [volumes vol'];
            volumes = unique(volumes);
        end
    end
    
    
    if ~isempty(volumes) % meaning: if there are volumes to be taken
        total = 600;   % total = total number of volumes
        x = zeros(total,length(volumes));
        
        for j = 1:length(volumes)
            
            
            % regressor_num = which volume to regress out
            regressor_num = volumes(j);
            
            
            thisparticipantpath=sprintf('%s%s',path,'/',participants{crun});
            cd(thisparticipantpath)
            
            x(regressor_num,j) = 1;
            out = x;
            %             x = num2str(x);
            
        end
        
        % write matrix on txt file
        fname = 'volumes_regressor_matrix.txt';
        fid = fopen(fname,'w');
        for ii = 1:size(out,1)
            fprintf(fid,'%d\t',out(ii,:));
            fprintf(fid,'\n');
        end
        fclose(fid);
        
        %             fprintf('%s \n',x);
        %             fprintf('Regressor %d of %d saved in %s. \n',regressor_num,total,fname);
        
        
    end
end




    
    
    
    
    
   


