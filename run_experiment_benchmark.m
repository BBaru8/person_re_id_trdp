clc
clear all
%% Main file to run the experiment 
env_setup;

%% Pre Processing of Data
preProp='Luminance'; %No for No Preprocessing, Midway, Luminance
preProcessingData;
%% parameters for data
% name - ['viper','airport','DukeMTMC','caviar'];
% datafolder - path to the folder for datasets
% pair - specific camera pairs (valid for ['raid','ward','saivt'])

params = { 'name','viper',...       % dataset name [viper, airport, DukeMTMC, caviar], VIPeRLM, VIPeRMD
           'datafolder',datafolder,...% folder for datasets
           'pair',[]};              % specific camera pairs
dopts = setParam('dataset',params);
%% parameters for feature extraction
% featureType - ['whos', 'gog', 'gbicov', 'ldfv', 'color_texture', 'hist_lbp', 'lomo']
% numRow/numCol/overlap - parameters for bounding box partition 
% CNNs: alexnet | densenet201 | googlenet | inceptionresnetv2 | inceptionv3 | resnet101 | resnet18 | resnet50 | squeezenet | vgg16 | vgg19
params = { 'featureType','GOG',... % feature type [whos, gog, gbicov, ldfv, color_texture, hist_lbp, lomo] aft
           'numRow',6,...           % number of split rows    
           'numCol',1,...           % number of split cols
           'overlap',0,...          % indicator for overlapping split (50%)
           'doPCA',1,...            % indicator for PCA dimension reduction
           'pcadim',100};           % PCA dimensions
fopts = setParam('feature',params);
%% parameters for metric learning 
kernel=0;
if kernel==1
    params = { 'method','klfda',...      % metric learning method [fda, lfda, klfda, mfa, kmfa, xqda, pcca, rpcca, kpcca, NFST, kissme, prdc, svmml]
            'kernels','exp'};           % kernel types [linear, chi2, chi2-rbf, exp]
else
    params = { 'method','xqda'};%% xqda lfda
end

mopts = setParam('metric',params);
%% parameters for ranking
params = { 'rankType','rnp',...     % rank type for multi-shot [rnp, srid, ahisd]
           'saveMetric',1,...       % indicator for saving learned metric
           'saveInterm',1};         % indicator for saving intermediate results
ropts = setParam('ranking',params);

%% evaluate 
run_one_experiment;

%% Visualise the images with their Ranking
feat = fopts.featureType;
algo = mopts.method;% lfda xqda
visualise_failcase;