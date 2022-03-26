% figure; imshow(osimg,[])
osimg = imrotate(osimg,180);
figure; imshow(osimg,[])
figure; imshow(usimg,[])
clc
color_norm_usimg    = stainnorm_reinhard(usimg ,osimg);   % transfer color
%     denoised_color_norm_usimg   =   NLMF(im2double(color_norm_usimg), Options);
[mosaic,r1,r2,r3]   = sift_register1(usimg, color_norm_usimg, osimg);
figure; imshow(mosaic,[])
figure; imshow(r2,[])
imtool(r2,[])
% t_us = r2(7:end, 20:end,:);
figure; imshow(t_us,[])
% t_os = r1(7:end, 20:end,:);
figure; imshow(t_us,[])
% figure; imshow(t_os,[])
clc
DenoisedImg = FAST_NLM_III(im2double(rgb2gray(t_us)), im2double(rgb2gray(t_os)),5,7,0.15);
figure; imshow(DenoisedImg,[])
figure; imshow(rgb2gray(t_os),[])
DenoisedImg1 = FAST_NLM_III(im2double(t_us(:,:,1)), im2double(t_os(:,:,1)),10,25,0.15);...
DenoisedImg2 = FAST_NLM_III(im2double(t_us(:,:,2)), im2double(t_os(:,:,2)),10,25,0.15);...
DenoisedImg3 = FAST_NLM_III(im2double(t_us(:,:,3)), im2double(t_os(:,:,3)),10,25,0.15);...
DenoisedColorImg(:,:,1)=DenoisedImg1; DenoisedColorImg(:,:,2)=DenoisedImg2;DenoisedColorImg(:,:,3)=DenoisedImg3;...
figure; imshow(DenoisedColorImg,[])
figure; imshow(r2,[])
figure; imshow(t_us,[])
diff_img = imfuse(DenoisedColorImg, t_us, 'diff');
figure; imshow(diff_img,[])
imtool(diff_img,[])
figure; imshow(diff_img>20,[])
figure; imshow(DenoisedColorImg,[])
t_us_ycbcr  = rgb2ycbcr(t_us);
t_os_ycbcr  = rgb2ycbcr(t_os);
t_us_y      = t_us_ycbcr(:,:,1);
t_os_y      = t_os_ycbcr(:,:,1);

DenoisedImg1 = FAST_NLM_III(im2double(t_us_y), im2double(t_os_y),7,25,0.15);
DenoisedImg2 = FAST_NLM_II(im2double(t_us_y),7,10,0.15);
result1(:,:,1)  =   DenoisedImg1;
result1(:,:,2)  =   t_os_ycbcr(:,:,2); result1(:,:,3)  =   t_os_ycbcr(:,:,3);
result2(:,:,1)  =   DenoisedImg2;
result2(:,:,2)  =   t_os_ycbcr(:,:,2); result2(:,:,3)  =   t_os_ycbcr(:,:,3);
result1_rgb = ycbcr2rgb(result1);
result2_rgb = ycbcr2rgb(result2);

DenoisedImg11 = FAST_NLM_II(im2double(t_us(:,:,1)),10,12,0.15);...
DenoisedImg21 = FAST_NLM_II(im2double(t_us(:,:,2)), 10,12,0.15);...
DenoisedImg31 = FAST_NLM_II(im2double(t_us(:,:,3)),10,12,0.15);...
DenoisedColorImg1(:,:,1)=DenoisedImg11; 
DenoisedColorImg1(:,:,2)=DenoisedImg21;DenoisedColorImg1(:,:,3)=DenoisedImg31;