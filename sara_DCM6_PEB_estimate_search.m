%% This script estimates a second level PEB model and searchers over nested PEB models to prune away parameters that don't contribute to the model evidence
%% Edit the parameters below
N = 63; % specify here the number of subjects / runs in your GCM file
path = '/projects/pbic1036/sara/bids_m1_data/derivatives/analysis/DCM'; % path where you have the estimated GCM file
gcm_name = 'GCM_estimated.mat'; % name of your GCM file
%%
cd(path);
load(gcm_name);

%% PEB estimation
% Specify PEB model settings (see batch editor for help on each setting)
M = struct();
M.alpha = 1;
M.beta  = 16;
M.hE    = 0;
M.hC    = 1/16;
M.Q     = 'all';

% Specify design matrix for N subjects. It should start with a constant column
% M.X = ones(N,1); % this will just calculate the group mean
filepath =  '/projects/pbic1036/script_sara/DCM';
cd(filepath)

T = readtable('plain_t_contrasts_for_PEB.xlsx',...
    'ReadVariableNames',false);
A = table2array(T);

%% In this matrix A:

% T-test

% A(:,1) --> anodal = 1 ; cathodal = -1    anodal vs cathodal
% A(:,2) --> anodal = -1 ; cathodal = 1

% A(:,3) --> anodal = 1 ; sham = -1    anodal vs sham
% A(:,4) --> anodal = -1 ; sham = 1

% A(:,5) --> cathodal = 1 ; sham = -1    cathodal vs sham
% A(:,6) --> cathodal = -1 ; sham = 1



M.X = zeros(N,24);    % column 1 for constant, column 2 for contrasts, plus 21 columns for subjects
M.X(:,1) = ones(N,1);
M.X(:,2) = A(:,3);    % Change this to take different comparisons as specified above
M.X(:,3) = A(:,6);

participants = 1:3:63;
m = 4;
for n = 1:21
    current = zeros(N,1);
    current(participants(n):participants(n)+2,1) = ones(3,1);
    M.X(:,m) = current;
    m = m+1;
end

% Choose field
field = {'A'};
%  {'B'}'; % it's recommended to run this separately for the A and the B matrix.

% Estimate model
PEB     = spm_dcm_peb(GCM,M,field);

% change the name below
cd(path)
save('PEB_two_contrasts.mat','PEB');


%% Compare nested PEB models. Decide which connections to switch off based on the
% structure of each DCM for subject 1.
% BMA = spm_dcm_peb_bmc(PEB(1), GCM(1,:));

%% % Search over nested PEB models.

BMA = spm_dcm_peb_bmc(PEB(1));


save BMA_two_contrasts BMA

%% Review results

spm_dcm_peb_review(BMA,GCM);
