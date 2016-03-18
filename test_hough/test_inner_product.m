clc
clear;
close all;
img1=imread('spectrums/Healthy.png');
img2=imread('spectrums/pancreatic cancer.png');
img1=double(img1);
img2=double(img2);
inner=img1 .* img2 ./ (img1.^1/2)   ./ (img2.^1/2)  ;
inner=inner(:,:,1).*inner(:,:,2);
inner=im2uint8(inner);
imshow(255-inner);