# DCM-for-resting-state-tDCS

In this repository are all the scripts I used to perform Dynamic Causal Model (DCM) analysis on rs-fMRI data during tDCS
In contains the whole pipeline from preprocessing of raw nifti data to the end.

PIPELINE:

1) m1_hide_session_names.m to change "anodal", "cathodal" and "sham" into different labels

2) sara_bids_creator_m1.m  to change data structure into BIDS format

3) Preprocessing: PREPROCESSING_motion_095threshold.m

4) Find out excessive movement volumes for each subj: sara_maxmov_rel.m (create a report for each subject)
                                                      find_excessive_motion_sara.m  (create a table of all subjects)
                                                      sara_regressor_fmri.m  (create a regr matrix of 0s/1s for each subj/ses)

5) ROI extraction for quality check:  ROI_extraction.m  (contains three different ways of performing rois extraction)

6) First level GLM to extract time series for DCM:
    a) sara_INF_single_NO_regressors.m  -    GLM for WHOLE data from participants without excessive movement
    b) sara_INF_single_REGRESSORS.m     -    GLM for WHOLE data from participants WITH excessive movement regressors

7) Selection of VOIs (extraction of fmri time series of ROIs only):   sara_VOIselection_indiv_coords.m

8) DCM Parameter estimation (to be done after DCM specification):  sara_dcm_fix_by_peter_zeidman.m
9) Group PEB analysis:  sara_DCM6_PEB_estimate_search.m



VARIOUS SCRIPTS NOT INCLUDED IN THE DCM PIPELINE:
-Creation of binary mask from wc1, wc2, wc3:    sara_binary_mask_creation.m 
-Temporal Filtering: sara_filter_resting_data.m
-Unzip and delete compressed files: unzip_and_delete.m 
-Split regressor txt files into 4 chunks :      split_text_file.m
-Creation of 4 chunks from fMRI time series:    split_chunks_creation.m
-sara_INF_4_NO_regressors.m      -    GLM for split data from participants without excessive movement
-sara_INF_4_REGRESSORS.m         -    GLM for split data from participants WITH excessive movement regressors
