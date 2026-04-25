clear;clc;close all;
cd(fileparts(mfilename('fullpath')));

% ====================== 1. 读取 BMP 图像 ======================
I = imread('bmp_test.bmp');
figure, imshow(I); title('原始BMP图像');

% 正确步骤：先转灰度 → 再转二值（黑白）
grayI = rgb2gray(I);   % 转灰度图
gg = imbinarize(grayI); % 新版二值化函数（替代im2bw）
figure, imshow(gg); title('BMP二值黑白图像');

% ====================== 2. 读取 JPG 图像 ======================
I = imread('lenna.jpg');
whos I;
figure, imshow(I); title('原始JPG图像');
imfinfo('lenna.jpg');

% 保存图像
imwrite(I,'filename.jpg','Quality',99);
imwrite(I,'filename.bmp');

I1 = imread('filename.jpg');
grayImage = rgb2gray(I1); % 转灰度
gg = imbinarize(grayImage); % 转二值（纯黑白）
figure, imshow(gg); title('JPG二值黑白图像');

% ====================== 3. 读取 PNG 图像 ======================
I = imread('butterfly.png');
whos I;
figure, imshow(I); title('原始PNG图像');

% 必须：灰度 → 二值化，才会显示纯黑白
gg = rgb2gray(I);       % 灰度图
bw_gg = imbinarize(gg); % 二值黑白图
figure, imshow(bw_gg); title('PNG二值黑白图像');