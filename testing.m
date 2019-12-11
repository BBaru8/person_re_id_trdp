%%testing
clc;
clear all;
load('AlexNet.mat');
imds = imageDatastore('VIPeR','IncludeSubfolders',true,'LabelSource','foldernames');
[imdsTrain,imdsValidation] = splitEachLabel(imds,0.7);

if isa(net,'SeriesNetwork')      
    lgraph = layerGraph(net.Layers); 
else
    lgraph = layerGraph(net);
end

[learnableLayer,classLayer] = findLayersToReplace(lgraph);

numClasses = numel(categories(imdsTrain.Labels));

if isa(learnableLayer,'nnet.cnn.layer.FullyConnectedLayer')
    newLearnableLayer = fullyConnectedLayer(numClasses, ...
    'Name','new_fc', ...        
    'WeightLearnRateFactor',10, ...
    'BiasLearnRateFactor',10);
elseif isa(learnableLayer,'nnet.cnn.layer.Convolution2DLayer')
    newLearnableLayer = convolution2dLayer(1,numClasses, ...
        'Name','new_conv', ...
        'WeightLearnRateFactor',10, ...
        'BiasLearnRateFactor',10);
end

figure('Units','normalized','Position',[0.3 0.3 0.4 0.4]);
plot(lgraph)
ylim([0,10])