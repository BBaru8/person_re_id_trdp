%Pre-Processing of data
%This function implements Pre-processing of VIPeR Dataset
% 
if exist('./Data','dir')  
        rmdir('./Data','s');
        disp('Deleting Existing Data......');
end

if strcmp(preProp,'Midway')
    % Midway
    disp('Pre-Processing: Midway Image Equalization ......');
    camOneFolder = './DataOriginal/VIPeR/cam1';  
    camOneFileList   = dir(fullfile(camOneFolder, '**', '*.bmp'));
    camTwoFolder = './DataOriginal/VIPeR/cam2';
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
            path=sprintf('./Data/%s/%s/%s/',myFolders{length(myFolders)-2},myFolders{length(myFolders)-1},myFolders{length(myFolders)});
            mkdir(path);
            imageOnePath = fullfile(path, camOneFileList(iFile).name);
            imwrite(imageOne,imageOnePath);
            imageTwoPath = fullfile(camTwoFileList(iFile).folder);
            myFolders = split(imageTwoPath,"\");
            path=sprintf('./Data/%s/%s/%s/',myFolders{length(myFolders)-2},myFolders{length(myFolders)-1},myFolders{length(myFolders)});
            mkdir(path);
            imageTwoPath = fullfile(path, camTwoFileList(iFile).name);
            imwrite(imageTwo,imageTwoPath);
        end
    else
        error('Database Size Error!'); 
    end
elseif strcmp(preProp,'Luminance')
    % Luminance 
    camOneFolder = './DataOriginal/VIPeR/cam1';  
    camOneFileList   = dir(fullfile(camOneFolder, '**', '*.bmp'));
    camTwoFolder = './DataOriginal/VIPeR/cam2';
    camTwoFileList   = dir(fullfile(camTwoFolder, '**', '*.bmp'));
    disp('Pre-Processing: Luminance Remapping ......');

    if numel(camOneFileList)==numel(camTwoFileList)
        for iFile = 1:numel(camOneFileList)
            camOneFile = fullfile(camOneFileList(iFile).folder, camOneFileList(iFile).name);
            image1=imread(camOneFile);
            camTwoFile = fullfile(camTwoFileList(iFile).folder, camTwoFileList(iFile).name);
            image2=imread(camTwoFile);
            imageTwo =luminance_remap(image1,image2);
            imageOnePath = fullfile(camOneFileList(iFile).folder);
            myFolders = split(imageOnePath,"\");
            path=sprintf('./Data/%s/%s/%s/',myFolders{length(myFolders)-2},myFolders{length(myFolders)-1},myFolders{length(myFolders)});
            mkdir(path);
            imageOnePath = fullfile(path, camOneFileList(iFile).name);
            imwrite(image1,imageOnePath);
            imageTwoPath = fullfile(camTwoFileList(iFile).folder);
            myFolders = split(imageTwoPath,"\");
            path=sprintf('./Data/%s/%s/%s/',myFolders{length(myFolders)-2},myFolders{length(myFolders)-1},myFolders{length(myFolders)});
            mkdir(path);
            imageTwoPath = fullfile(path, camTwoFileList(iFile).name);
            imwrite(imageTwo,imageTwoPath);
        end
    else
        error('Database Size Error!'); 
    end
else 
    disp('No Pre-Processing. Working on Original Dataset');
    copyfile ./DataOriginal/ ./Data/
end

