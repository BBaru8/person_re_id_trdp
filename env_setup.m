%% envrionment setup, need to be modifed accordingly

% modify the path point to the folder of datasets
datafolder = './Data';

% load vlfeat
run('./3rdParty/vlfeat-0.9.20/toolbox/vl_setup.m')

addpath(genpath('./FeatureExtraction'))
addpath(genpath('./MetricLearning'))
addpath(genpath('./util'))
addpath(genpath('./TrainTestSplits'))
addpath(genpath('./Evaluation'))
addpath(genpath('./Pre_Processing'))

% Delete mat files
delete .\FeatureExtraction\*.mat;
% make dir
if exist('./Results','dir')  
        rmdir('./Results','s');
        disp('Deleting Existing Result Data......');
end
mkdir('Results');

if exist('./Visual_FailCasesImagaes','dir')  
        rmdir('./Visual_FailCasesImagaes','s');
        disp('Deleting Existing Visual Fail Cases Images......');
end
mkdir('Visual_FailCasesImagaes');