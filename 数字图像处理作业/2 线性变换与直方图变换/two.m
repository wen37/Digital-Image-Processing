clear;clc;close all;
cd(fileparts(mfilename('fullpath')));

I=imread('camera.png');
figure(1),subplot(2,2,1),imshow(I),title('原始灰度图像');
% 利用imhist显示直方图
figure(2),subplot(2,2,1),imhist(I),title('灰度图像的直方图'); 

% 用histeq函数进行直方图均衡化
H=histeq(I);
figure(1),subplot(2,2,2),imshow(H),title('直方图均衡化后图像');
figure(2),subplot(2,2,2),imhist(H),title('均衡化后图像的直方图');

% 用imadjust函数进行线性变换，将[0-1]灰度映射到[1-0]灰度
I1=imadjust(I,[0 1],[1 0]);
figure(1),subplot(2,2,3),imshow(I1),title('线性变换 1 后图像');
figure(2),subplot(2,2,3),imhist(I1),title('线性变换 1 后的直方图');

% 用imadjust函数进行线性变换，将[0.3-0.7]灰度映射到[0.1-0.9]灰度
I2=imadjust(I,[0.3 0.7],[0.1 0.9]);
figure(1),subplot(2,2,4),imshow(I2),title('线性变换 2 后图像');
figure(2),subplot(2,2,4),imhist(I2),title('线性变换 2 后的直方图');