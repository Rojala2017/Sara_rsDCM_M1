# DCM-for-resting-state-tDCS

In this repository are all the scripts I used to perform Dynamic Causal Model (DCM) analysis on rs-fMRI data during tDCS
In contains the whole pipeline from preprocessing of raw nifti data to the end.

PIPELINE:

1) Preprocessing: PREPROCESSING_motion_095threshold.m

2) Find out excessive movement volumes for each subj: sara_maxmov_rel.m (create a report for each subject)
                                                      find_excessive_motion_sara.m  (create a table of all subjects)
                                                      sara_regressor_fmri.m  (create a regr matrix of 0s/1s for each subj/ses)

3) Creation of binary mask from wc1, wc2, wc3:    sara_binary_mask_creation.m 

4)Temporal Filtering:                             sara_filter_resting_data.m

5) Creation of 4 chunks from firm time series:    split_chunks_creation.m

6) First level GLM to extract time series for DCM:  sara_glm.m

7) Selection of VOIs (extraction of fmri time series of ROIs only):   sara_VOIselection_indiv_coords.m
