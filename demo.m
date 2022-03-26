
%% Code to fuse Varying exposure images
% Written by    : K Ram Prabhakar
% Date          : 20/07/2015
% Input         : 3 images

%% Add path
clc;
warning('off','all');
addpath('./Bilateral filter/');
addpath('utils');
addpath('gradient fusion');
addpath('mdaisy-v1.0\');

%% Select files
PathName    =   'E:\Ram\Codes\Image_fusion\images';
path = 'E:\Ram\Codes\Image_fusion\Final_codes\results';
[FileName{1},PathName] = uigetfile({'*.jpg; *.tif;*.png; *.tiff'},'Select the under saturated image',PathName);
[FileName{2},PathName] = uigetfile({'*.jpg; *.tif;*.png; *.tiff'},'Select the reference image', PathName);
[FileName{3},PathName] = uigetfile({'*.jpg; *.tif;*.png; *.tiff'},'Select the over saturated image',PathName);

%% Generate Latent images
[imgStack, LatentImgs]  = main(PathName, FileName);

%% Fuse Latent images
FusedIm1       = GetFusedImg(LatentImgs);

%% Store the result
rem = strcat(PathName,'\');
while strcmp(rem,'\') ~= 1
    [tok, rem] = strtok(rem,'\');
end
folder = tok;
t = clock;
filename = strcat(num2str(t(3)),'_', num2str(t(2)),'_', num2str(t(1)),'_',num2str(t(4)),'_',num2str(t(5)));
imwrite(FusedIm1, fullfile(path, folder,strcat('Result_Proposed_', filename,'.jpg')),'jpg');
% imwrite(FusedImg2, fullfile(path, folder,strcat('Result_HDRDeghosting', filename,'.jpg')),'jpg');
%     figure(1); subplot 231; imshow(uint8(imgStack{1}),[]);
%     subplot 232; imshow(uint8(imgStack{2}),[]);
%     subplot 233; imshow(uint8(imgStack{3}),[]);
%     subplot 234; imshow(uint8(LatentImgs1{1}),[]);
%     subplot 235; imshow(uint8(LatentImgs1{2}),[]);
%     subplot 236; imshow(uint8(LatentImgs1{3}),[]);
% 
%     figure(2); imshow(uint8(FusedImg1),[]);
