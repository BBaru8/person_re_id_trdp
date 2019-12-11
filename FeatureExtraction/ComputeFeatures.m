%%%%%
% Main script to compute features
% Inputs: img: {MxNx3} image(s) to compute features
%         method: structure to keep the parameter 
%           .name: 'gbicov','ldfv','sdc','color_texture', 'hist_LBP',
%           'lomo','gog'
%           .idx_train: training index
% Output: x: feature vector
%         method: parameters to keep
%%%%%

function [x,method,strs]=ComputeFeatures(img,method,strs)
warning off

imsz = size(img{1});
patches = method.patchSize;
grids = method.stepSize;
if ~iscell(img)
    img = {img};
end

switch lower(method.featureType)
    case 'alexnet'
        net=alexnet;
        layer='fc7';
        imds=imageDatastore(strs);
        inputSize = net.Layers(1).InputSize;
        augimdsTrain = augmentedImageDatastore(inputSize(1:2),imds);
        x=activations(net,augimdsTrain,layer,'OutputAs','rows');
    case 'alexnetfeaturetrained'
        trainedNet=load('AlexNetTrainedSmallmarket.mat');
        net=trainedNet.net;
        layer='fc7';
        imds=imageDatastore(strs);
        inputSize = net.Layers(1).InputSize;
        augimdsTrain = augmentedImageDatastore(inputSize(1:2),imds);
        x=activations(net,augimdsTrain,layer,'OutputAs','rows');
    case 'aft'
        net=alexnet;
        layer='fc7';
        imds=imageDatastore(strs);
        inputSize = net.Layers(1).InputSize;
        augimdsTrain = augmentedImageDatastore(inputSize(1:2),imds);
        y=activations(net,augimdsTrain,layer,'OutputAs','rows');
        net=resnet101;
        layer='pool5';%%%% UPDATED
        imds=imageDatastore(strs);
        
        inputSize = net.Layers(1).InputSize;
        augimdsTrain = augmentedImageDatastore(inputSize(1:2),imds);
        x=activations(net,augimdsTrain,layer,'OutputAs','rows');
        x=[x y];
    case 'v19gnet'
        net=vgg19;
        layer='fc7';
        imds=imageDatastore(strs);
        
        inputSize = net.Layers(1).InputSize;
        augimdsTrain = augmentedImageDatastore(inputSize(1:2),imds);
        a=activations(net,augimdsTrain,layer,'OutputAs','rows');
        net=googlenet;
        layer='pool5-drop_7x7_s1';%% from MATLAB Answer369606
        imds=imageDatastore(strs);
        
        inputSize = net.Layers(1).InputSize;
        augimdsTrain = augmentedImageDatastore(inputSize(1:2),imds);
        b=activations(net,augimdsTrain,layer,'OutputAs','rows');
        x=[a b];
    case 'vgg16'
        net=vgg16;
        layer='fc7';
        imds=imageDatastore(strs);
        inputSize = net.Layers(1).InputSize;
        augimdsTrain = augmentedImageDatastore(inputSize(1:2),imds);
        x=activations(net,augimdsTrain,layer,'OutputAs','rows');        
    case 'vgg19'
        net=vgg19;
        layer='fc7';
        imds=imageDatastore(strs);
        
        inputSize = net.Layers(1).InputSize;
        augimdsTrain = augmentedImageDatastore(inputSize(1:2),imds);
        x=activations(net,augimdsTrain,layer,'OutputAs','rows'); 
    case 'squeezenet'
        net=squeezenet;
        layer='pool10';%%%% NEED UPDATE
        imds=imageDatastore(strs);
        
        inputSize = net.Layers(1).InputSize;
        augimdsTrain = augmentedImageDatastore(inputSize(1:2),imds);
        x=activations(net,augimdsTrain,layer,'OutputAs','rows'); 
    case 'googlenet'
        net=googlenet;
        layer='pool5-drop_7x7_s1';%% from MATLAB Answer369606
        imds=imageDatastore(strs);
        
        inputSize = net.Layers(1).InputSize;
        augimdsTrain = augmentedImageDatastore(inputSize(1:2),imds);
        x=activations(net,augimdsTrain,layer,'OutputAs','rows');     
    case 'inceptionv3'
        net=inceptionv3;
        layer='avg_pool';%%%% from analyzeNetwork: inceptionv3 return 1x1x1000
        imds=imageDatastore(strs);
        
        inputSize = net.Layers(1).InputSize;
        augimdsTrain = augmentedImageDatastore(inputSize(1:2),imds);
        x=activations(net,augimdsTrain,layer,'OutputAs','rows');
    case 'densenet201'
        net=densenet201;
        layer='fc1000';%%%% from analyzeNetwork: fc1000 return 1x1x1000 avg_pool
        imds=imageDatastore(strs);
        
        inputSize = net.Layers(1).InputSize;
        augimdsTrain = augmentedImageDatastore(inputSize(1:2),imds);
        x=activations(net,augimdsTrain,layer,'OutputAs','rows');
    case 'resnet18'
        net=resnet18;
        layer='pool5';%% UPDATED
        imds=imageDatastore(strs);
        
        inputSize = net.Layers(1).InputSize;
        augimdsTrain = augmentedImageDatastore(inputSize(1:2),imds);
        x=activations(net,augimdsTrain,layer,'OutputAs','rows');
    case 'resnet50'
        net=resnet50;
        layer='avg_pool';%%%% UPDATED
        imds=imageDatastore(strs);
        
        inputSize = net.Layers(1).InputSize;
        augimdsTrain = augmentedImageDatastore(inputSize(1:2),imds);
        x=activations(net,augimdsTrain,layer,'OutputAs','rows');
    case 'resnet101'
        net=resnet101;
        layer='pool5';%%%% UPDATED
        imds=imageDatastore(strs);
        
        inputSize = net.Layers(1).InputSize;
        augimdsTrain = augmentedImageDatastore(inputSize(1:2),imds);
        x=activations(net,augimdsTrain,layer,'OutputAs','rows');
    case 'inceptionresnetv2'
        net=inceptionresnetv2;
        layer='avg_pool';%%%% NEED UPDATE
        imds=imageDatastore(strs);
        
        inputSize = net.Layers(1).InputSize;
        augimdsTrain = augmentedImageDatastore(inputSize(1:2),imds);
        x=activations(net,augimdsTrain,layer,'OutputAs','rows');
    case 'whos'
        patchsize = patches;%[imsz(2) 20]; 
        gridstep = grids;%[imsz(2) 20];
        imsz = size(img{1});
        imsz = imsz(1:2);
        
        [kx,ky] = meshgrid(1:imsz(2),1:imsz(1));
        % centering
        kx = (kx - imsz(2)/2).^2;
        ky = (ky - imsz(1)/2).^2;
        sigma = (imsz/4).^2;
        K_no_iso_gaus = exp(-(kx./sigma(2))-(ky./sigma(1)));
        fprintf('Begin to extract WHOS feature');
        parfor i = 1:numel(img)
            if mod(i,round(numel(img)/10))==0
                fprintf('.');
            end               
            x(i,:) = PETA_cal_img_full_hist(img{i},K_no_iso_gaus,1,patchsize,gridstep);
        end
        fprintf('Done!\n')
        fprintf('# dimensions --- %d\n',size(x,2));
    case 'gog'
        param=set_default_parameter(1);
        param.lfparam.usebase = [1 1 1 0 0 0];
        param.lfparam.num_element = 8;
        param.lfparam.lf_name = 'yMRGB';
        param.d = 8;
        param.G = method.numPatch; % 6 strip
        param.patchSize = floor(patches);
        param.gridSize = floor(grids);        
        method.option = param;
        fprintf('Begin to extract GOG feature');
        x=GOGHelper(img,param);
        fprintf('Done!\n')
        fprintf('# dimensions --- %d\n',size(x,2));
    case 'gbicov'
        % default setting: size - [16 16]; step - [4 4]
        % 6 strips - [48 20]
        patchsize = floor(patches); %patchs;%[imsz(2) 20]; 
        gridstep = floor(grids); %grids;%[imsz(2) 20];

        fprintf('Begin to extract gbicov feature...');
        x = gbicovEx(img,patchsize,gridstep);
        x = x';   
        fprintf('Done!\n')
        fprintf('# dimensions --- %d\n',size(x,2));
    case 'ldfv'
        nNode = 16;
        method.option.nNode = nNode;
        
        patchsize = floor(patches); %patchs;%[imsz(2) 20]; 
        gridstep = floor(grids); %grids;%[imsz(2) 20];                
        method.numPatch = floor(((size(img{1},2) - patchsize(1))/gridstep(1)+1))...
                        * floor(((size(img{1},1) - patchsize(2))/gridstep(2)+1));
        
        train = find(method.idx_train);    
        fprintf('Begin to extract LDFV feature...');
        x = LDFV(img,train, patchsize,gridstep,nNode);
        fprintf('Done!\n')
        fprintf('# dimensions --- %d\n',size(x,2));
    case 'sdc'
        patchsize = patches;%[imsz(2) 128/6]; %[10 10];%
        gridstep = grids;%[imsz(2) 128/6]; %[4 4];%
        
        fprintf('Begin to extract DenseColorSIFT feature...');
        x = dense_colorsift(img,patchsize,gridstep);
        x = x';
        fprintf('Done!\n')
        fprintf('# dimensions --- %d\n',size(x,2));
    case 'color_texture'
        nBins=16;        
        method.options.nBins = nBins;
        
        fprintf('Begin to extract ELF feature...');
        x=colorTexture(img,method.numRow,nBins);
        fprintf('Done!\n')
        fprintf('# dimensions --- %d\n',size(x,2));        
    case 'hist_lbp'
        nBins=16;        
        method.options.nBins = nBins;
        
        patchsize = patches;%[imsz(2) 128/6];
        gridstep = grids;%[imsz(2) 128/6];       
        fprintf('Begin to extract HistLBP feature...');
        x=HistLBP(img,nBins,patchsize,gridstep);
        fprintf('Done!\n')
        fprintf('# dimensions --- %d\n',size(x,2));      
    case 'lomo'
        options.numScales = 1;
        options.blockSize = round(min(patches)); %patchs(1);%
        options.blockStep = round(min(patches)); % grids(1);
        options.hsvBins = [8,8,8];
        options.tau = 0.3;
        options.R = [3, 5];
        options.numPoints = 4;
        method.options = options;
        
        [h,w,~] = size(img{1});
        images = zeros(h, w, 3, numel(img), 'uint8');
        for i = 1 : numel(img)
            images(:,:,:,i) = img{i};
        end
        fprintf('Begin to extract LOMO feature...');
        x = LOMO(images, options);
        x = x';
        fprintf('Done!\n')
        fprintf('# dimensions --- %d\n',size(x,2));      
end
x = single(x);
warning on
end

