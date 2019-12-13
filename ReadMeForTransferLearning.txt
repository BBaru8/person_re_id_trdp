For Transfer Learning of MATLAB CNN Models, please use "alexnetFeatImprovre.m". 

1. Select appropriate network. 
For us, 
>> net=alexnet; %change model name as of your choice

2. Provide appropriate folder as input. The images that you want re-train the network on. 
>> imds = imageDatastore('mix','IncludeSubfolders',true,'LabelSource','foldernames'); 
%Set the folder name, for us, it is 'mix'

3. Then select the layers to freeze.
>> layers(1:10) = freezeWeights(layers(1:10));

4. And save the model. Change accordingly.
>> save('AlexNetTrainedSmallmarket.mat','net');

5. Once you are done, then copy the .mat file (for us,'AlexNetTrainedSmallmarket.mat') in "FeatureExtraction" Folder.

6. Then, in ComputeFeatures.m modify this following case accordingly. Or you can add new case. Remember, you will need to use the same "case" name as 
an input of parameters for feature extraction in "run_experiment_benchmark.m"

 case 'alexnetfeaturetrained'
        trainedNet=load('AlexNetTrainedSmallmarket.mat');
        net=trainedNet.net;
        layer='fc7';
        imds=imageDatastore(strs);
        inputSize = net.Layers(1).InputSize;
        augimdsTrain = augmentedImageDatastore(inputSize(1:2),imds);
        x=activations(net,augimdsTrain,layer,'OutputAs','rows');

After this run "run_experiment_benchmark.m".

7. If you want to visualize and pre-process dataset use "run_experiment_benchmark.m". Follow the same instructions for this step as well.