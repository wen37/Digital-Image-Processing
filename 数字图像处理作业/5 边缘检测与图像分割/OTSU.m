clear;clc;close all;
cd(fileparts(mfilename('fullpath')));

img=imread('stadium.jpg');

% 显示原图像
figure;
subplot(2,2,1);
imshow(img);
title('原图');

% 如果图像是彩色的，转换为灰度图
if size(img,3)==3
    gray_img=rgb2gray(img);
else
    gray_img=img;
end

% 显示灰度图像
subplot(2,2,2);
imshow(gray_img);
title('灰度图');

% OTSU分割方法
level_otsu=graythresh(gray_img);
otsu_img=imbinarize(gray_img,level_otsu);

% 显示OTSU阈值分割后的图像
subplot(2,2,3);
imshow(otsu_img);
title(['OTSU分割，阈值=',num2str(level_otsu)]);

% 迭代阈值分割方法
% 初始阈值为中间值
T=mean(gray_img(:));
max_iter=100;
for iter=1:max_iter
    background=gray_img(gray_img<=T);
    foreground=gray_img(gray_img>T);
    T_new=(mean(background)+mean(foreground))/2;
    % 如果阈值变化很小，停止迭代
    if abs(T_new-T)<1e4
        break;
    end
    T=T_new;
end

% 根据最终阈值T进行分割
iter_img=gray_img>T;

% 显示迭代阈值分割后的图像
subplot(2,2,4);
imshow(iter_img);
title(['迭代阈值分割，阈值=',num2str(T)]);