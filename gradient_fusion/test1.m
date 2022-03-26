clear all;clc;
PathName    = 'D:\Ph.D\Image_fusion';
[FileName{1},PathName] = uigetfile({'*.jpg; *.tif;*.png'},'Select the under saturated image',PathName);
[FileName{2},PathName] = uigetfile({'*.jpg; *.tif;*.png'},'Select the reference image', PathName);
[FileName{3},PathName] = uigetfile({'*.jpg; *.tif;*.png'},'Select the over saturated image',PathName);
%%
img_un  = imread(fullfile(PathName, FileName{1}));
img_ref = imread(fullfile(PathName, FileName{2}));
img_ov  = imread(fullfile(PathName, FileName{3}));
%%
maskNotClippIMFedPixels = im2double(img_ov) < .98;
% compute mask for clipped regions
maskClippIMFedPixels = ~maskNotClippIMFedPixels;
se      = strel('square',2);
maskClippIMFedPixels = imdilate(maskClippIMFedPixels, se);
% compute weight
mask    = maskClippIMFedPixels(:,:,1) ...\
& maskClippIMFedPixels(:,:,2) ...\
& maskClippIMFedPixels(:,:,3);
figure; imshow(~mask,[]);
mask_ov = ~mask;

%%
maskNotClippIMFedPixels = im2double(img_un) > .2;
maskClippIMFedPixels = ~maskNotClippIMFedPixels;
se      = strel('square',2);
maskClippIMFedPixels = imdilate(maskClippIMFedPixels, se);
% compute weight
mask    = maskClippIMFedPixels(:,:,1) ...\
& maskClippIMFedPixels(:,:,2) ...\
& maskClippIMFedPixels(:,:,3);
figure; imshow(~mask,[]);
mask_un = ~mask;

%%
maskNotClippIMFedPixels = im2double(img_ref) < .98;
% compute mask for clipped regions
maskClippIMFedPixels = ~maskNotClippIMFedPixels;
se      = strel('square',2);
maskClippIMFedPixels = imdilate(maskClippIMFedPixels, se);
% compute weight
mask    = maskClippIMFedPixels(:,:,1) ...\
& maskClippIMFedPixels(:,:,2) ...\
& maskClippIMFedPixels(:,:,3);
figure; imshow(~mask,[]);
mask_ref = ~mask;
mask_ref1 = ~mask_ov;

% %%
% fil = fspecial('disk',10);
% mask_un1 = im2uint8(mask_un);
% mask_ov1 = im2uint8(mask_ov);
% mask_ref1 = im2uint8(mask_ref);
% mask_un1 = im2double(imfilter(mask_un1, fil,'replicate'));
% mask_ov1 = im2double(imfilter(mask_ov1, fil,'replicate'));
% mask_ref1 = im2double(imfilter(mask_ref1, fil,'replicate'));
%%
masks(:,:,1 ) = mask_un;
masks(:,:,2 ) = mask_ref1;
masks(:,:,3 ) = mask_ov;
%%
I(:,:,:,1) = img_un;
I(:,:,:,2) = img_ref;
I(:,:,:,3) = img_ov;
%%
K = test2(I,masks);
K1 = GradientFusion(I);
figure; subplot 121; imshow(K,[]);
subplot 122; imshow(K1,[]);

%%
chrom_img1 = im2double(chrom_img);
K1 = im2double(K);
result = chrom_img1.*repmat(K1, [1 1 3]);