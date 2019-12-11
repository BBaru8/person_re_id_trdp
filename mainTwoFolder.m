% Final Code 
% This Code takes images from two different folders. 
% These two images are processed and stored in their corresponding new folders. 
close all, clear all;
%Input Folders
camOneFolder = './VIPeR/cam1';  
camOneFileList   = dir(fullfile(camOneFolder, '**', '*.bmp'));
camTwoFolder = './VIPeR/cam2';
camTwoFileList   = dir(fullfile(camTwoFolder, '**', '*.bmp'));

if numel(camOneFileList)==numel(camTwoFileList)
    for iFile = 1:numel(camOneFileList)
        camOneFile = fullfile(camOneFileList(iFile).folder, camOneFileList(iFile).name);
        image1=imread(camOneFile);
        camTwoFile = fullfile(camTwoFileList(iFile).folder, camTwoFileList(iFile).name);
        image2=imread(camTwoFile);
        [imageOne, imageTwo] =MidWay(image1,image2);
        imageOnePath = fullfile(camOneFileList(iFile).folder);
        myFolders = split(imageOnePath,"\");
        path=sprintf('./Midway/%s/%s/%s/',myFolders{3},myFolders{4},myFolders{5});
        mkdir(path);
        imageOnePath = fullfile(path, camOneFileList(iFile).name);
        imwrite(imageOne,imageOnePath);
        imageTwoPath = fullfile(camTwoFileList(iFile).folder);
        myFolders = split(imageTwoPath,"\");
        path=sprintf('./Midway/%s/%s/%s/',myFolders{3},myFolders{4},myFolders{5});
        mkdir(path);
        imageTwoPath = fullfile(path, camTwoFileList(iFile).name);
        imwrite(imageTwo,imageTwoPath);
    end
else
    error('Database Size Error!'); 
end




