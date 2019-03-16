# DCM-for-resting-state-tDCS

In this repository are all the scripts I used to perform Dynamic Causal Model (DCM) analysis on rs-fMRI data during tDCS
In contains the whole pipeline from preprocessing of raw nifti data to the end.

PIPELINE:

1) Preprocessing: PREPROCESSING_motion_095threshold.m

2) Find out excessive movement volumes for each subj: sara_maxmov_rel.m (create a report for each subject)
                                                      find_excessive_motion_sara.m  (create a table of all subjects)
                                                      sara_regressor_fmri.m  (create a regr matrix of 0s/1s for each subj/ses)

3) Creation of binary mask from wc1, wc2, wc3:    sara_binary_mask_creation.m  (OPTIONAL)

4) Temporal Filtering:                            sara_filter_resting_data.m
  Unzip and delete compressed files: unzip_and_delete.m (I forgot to include this in the temporal filtering script)

5) ROI extraction for quality check:  ROI_extraction.m  (contains three different ways of performing rois extraction)

6) Split regressor txt files into 4 chunks :      split_text_file.m
7) Creation of 4 chunks from fMRI time series:    split_chunks_creation.m

8) First level GLM to extract time series for DCM - 4 VERSIONS:
    a) sara_INF_single_NO_regressors.m  -    GLM for WHOLE data from participants without excessive movement
    b) sara_INF_single_REGRESSORS.m     -    GLM for WHOLE data from participants WITH excessive movement regressors
    c) sara_INF_4_NO_regressors.m      -    GLM for split data from participants without excessive movement
    d) sara_INF_4_REGRESSORS.m         -    GLM for split data from participants WITH excessive movement regressors

9) Selection of VOIs (extraction of fmri time series of ROIs only):   sara_VOIselection_indiv_coords.m
