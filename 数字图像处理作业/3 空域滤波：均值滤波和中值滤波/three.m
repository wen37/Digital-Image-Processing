clear;clc;close all;
cd(fileparts(mfilename('fullpath')));

I=imread('camera.png'); %使用 imread()函数读取一幅灰度图像
J1 = imnoise(I, 'gauss', 0.002); % 对图像添加高斯噪声 
J2 = imnoise(I, 'salt & pepper', 0.02); % 对图像添加椒盐噪声 
 
window=fspecial('average', 3); % 设置滤波器：均值滤波 3*3 
K = filter2(window, J1); % 对图像进行均值滤波 
L = filter2(window, J2); 
K = uint8(K); 
L = uint8(L); 
 
M = medfilt2(J1, [3 3]); % 对图像进行中值滤波 
N = medfilt2(J2, [3 3]); 
 
%利用 imshow()命令显示各步骤图像结果
subplot(2, 4, 1),imshow(I),title('Original Image'); 
subplot(2, 4, 2),imshow(J1),title('Gaussian Noise Image'); 
subplot(2, 4, 3),imshow(J2),title('Salt Noise Image'); 
subplot(2, 4, 5),imshow(K),title('Mean Filtering For Gaussian Noise'); 
subplot(2, 4, 6),imshow(M),title('Median Filtering For Gaussian Noise'); 
subplot(2, 4, 7),imshow(L),title('Mean Filtering For Salt Noise'); 
subplot(2, 4, 8),imshow(N),title('Median Filtering For Salt Noise');

% 读取图像
I=imread('camera.png');

% 对原始图像进行锐化
sharpening_filter=fspecial('unsharp'); % 使用反锐化掩蔽
I_sharpened=imfilter(I,sharpening_filter); % 对原始图像进行锐化

% 显示结果
figure;
subplot(1,2,1),imshow(I),title('Original Image');
subplot(1,2,2),imshow(I_sharpened),title('Sharpened Image');