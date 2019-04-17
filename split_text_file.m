path =  '/projects/pbic1036/sara/bids_m1_data/derivatives/preprocessing';  % path to my dataset
nsub = 11; % number of subjects

participants = {
      'sub-03/ses-03back'
      'sub-04/ses-02back'
      'sub-09/ses-03lung'
      'sub-14/ses-01back'
      'sub-14/ses-02lung'
      'sub-14/ses-03foot'
      'sub-16/ses-01back'
      'sub-16/ses-02lung'
      'sub-16/ses-03foot'
      'sub-24/ses-03back'
      'sub-25/ses-01back'
    };

for i = 1:nsub
    
 thisparticipant = sprintf('%s%s', path,'/',participants{i});
 cd(thisparticipant)
 
 % import data from the txt file with motion regressors
 regressor_file = importdata('volumes_regressor_matrix.txt');
 
 % split data into 4
 regr_motion_1 = regressor_file(1:150,:);
 regr_motion_2 = regressor_file(151:300,:);
 regr_motion_3 = regressor_file(301:450,:);
 regr_motion_4 = regressor_file(451:600,:);
 
 
 fid = fopen('regr_motion_1','wt');
        for ii = 1:size(regr_motion_1,1)
            fprintf(fid,'%d\t',regr_motion_1(ii,:));
            fprintf(fid,'\n');
        end
        fclose(fid);
 
         
 fid = fopen('regr_motion_2','wt');
        for ii = 1:size(regr_motion_2,1)
            fprintf(fid,'%d\t',regr_motion_2(ii,:));
            fprintf(fid,'\n');
        end
        fclose(fid);
        
         
 fid = fopen('regr_motion_3','wt');
        for ii = 1:size(regr_motion_3,1)
            fprintf(fid,'%d\t',regr_motion_3(ii,:));
            fprintf(fid,'\n');
        end
        fclose(fid);
        
         
 fid = fopen('regr_motion_4','wt');
        for ii = 1:size(regr_motion_4,1)
            fprintf(fid,'%d\t',regr_motion_4(ii,:));
            fprintf(fid,'\n');
        end
        fclose(fid);

 
end