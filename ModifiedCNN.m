net=alexnet;
imds = imageDatastore(strs, ...
            'IncludeSubfolders',true, ...
            'LabelSource','foldernames');
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
        lgraph = replaceLayer(lgraph,learnableLayer.Name,newLearnableLayer);
        newClassLayer = classificationLayer('Name','new_classoutput');
        lgraph = replaceLayer(lgraph,classLayer.Name,newClassLayer);
        layer='new_fc';
        imds=imageDatastore(strs);
        inputSize = net.Layers(1).InputSize;
        augimdsTrain = augmentedImageDatastore(inputSize(1:2),imds);
        x=activations(net,augimdsTrain,layer,'OutputAs','rows');        