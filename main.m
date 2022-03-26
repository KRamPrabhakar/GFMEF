
function [imgStack, LatentImgs]  = main(PathName, FileName)
    %% Code to fuse Varying exposure images
    % Written by    : K Ram Prabhakar
    % Date          : 20/07/2015
    % Input         : 3 images     

    addpath('./Fast_NLM/');
    addpath('./gradient fusion/');
    addpath('./utils/');
    %% Read images
    img_un  = imread(fullfile(PathName, FileName{1}));
    img_ref = imread(fullfile(PathName, FileName{2}));
    img_ov  = imread(fullfile(PathName, FileName{3}));
    
    img_un  = im2uint8(img_un);
    img_ref = im2uint8(img_ref);
    img_ov  = im2uint8(img_ov);
    
    [m,n,~] = size(img_un);
    
    if max(m,n) > 800
         ratio           = max(m,n) / 700;    
    else 
         ratio           = 1;
    end
    img_un  = imresize(img_un, 1/ratio);
    img_ref = imresize(img_ref, 1/ratio);
    img_ov  = imresize(img_ov, 1/ratio);
    
    %% Generating first latent image
    imgStack{1}     = img_un;
    ppIMF1          = computeimfhist(im2double(img_ref), im2double(img_un));
    intensityMappedRef1 = transfercolor(im2double(img_ref), ppIMF1);
    intensityMappedRef1(:,:,1) = FAST_NLM_II(im2double(intensityMappedRef1(:,:,1)),3,5,0.1);
    intensityMappedRef1(:,:,2) = FAST_NLM_II(im2double(intensityMappedRef1(:,:,2)),3,5,0.1);
    intensityMappedRef1(:,:,3) = FAST_NLM_II(im2double(intensityMappedRef1(:,:,3)),3,5,0.1);
    LatentImgs{1}       = im2uint8(intensityMappedRef1);    
    
    imgStack{2}     = img_ref;
    LatentImgs{2}   = img_ref;
    
    %% Generating second latent image
    imgStack{3}     = img_ov;
    ppIMF2          = computeimfhist(im2double(img_ref), im2double(img_ov));
    intensityMappedRef2 = transfercolor(im2double(img_ref), ppIMF2);
    intensityMappedRef2(:,:,1) = FAST_NLM_II(im2double(intensityMappedRef2(:,:,1)),3,5,0.05);
    intensityMappedRef2(:,:,2) = FAST_NLM_II(im2double(intensityMappedRef2(:,:,2)),3,5,0.05);
    intensityMappedRef2(:,:,3) = FAST_NLM_II(im2double(intensityMappedRef2(:,:,3)),3,5,0.05);
    LatentImgs{3}       = im2uint8(intensityMappedRef2);    
end