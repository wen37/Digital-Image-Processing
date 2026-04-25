clear;clc;close all;
cd(fileparts(mfilename('fullpath')));

% 读取图像
img=imread('coin.jpg');
% 转换为灰度图像
gray=rgb2gray(img);
% 边缘检测
edges=edge(gray,'canny');
% 显示检测图像
subplot(2,3,1);
imshow(edges);
title('检测后的图像');
% 检测圆
[centers,radii]=imfindcircles(edges,[10,30],'ObjectPolarity','bright');
% 显示检测到的圆
figure;imshow(img);hold on;
viscircles(centers,radii,'EdgeColor','b');
title('Detected Circles');

% 执行霍夫变换
[H,theta,rho]=hough(edges);
% 找到霍夫变换的峰值
P=houghpeaks(H,5,'Threshold',ceil(0.3*max(H(:))));
% 根据峰值检测直线
lines=houghlines(edges,theta,rho,P,'FillGap',5,'MinLength',20);
% 绘制直线
figure,imshow(img),hold on;
max_len=0;
for k=1:length(lines)
    xy=[lines(k).point1;lines(k).point2];
    plot(xy(:,1),xy(:,2),'g','LineWidth',2);
end
% 计算直线长度
len=norm(lines(k).point1-lines(k).point2);
if (len>max_len)
    max_len=len;
    % 保存最长的直线，假设为方盒的一边
    box_line=lines(k);
end
title('Detected Lines');

% 计算硬币个数
coinCount=size(centers,1);
disp(['硬币个数：',num2str(coinCount)]);
% 计算方盒边长
if ~isempty(lines)
    boxLength=norm(box_line.point1-box_line.point2);
    disp(['方盒边长：',num2str(boxLength)]);
else
    disp('无法检测到方盒的边');
end

%绘制方盒边缘
figure,imshow(img),hold on
for k=1:size(lines,1)
    plot( ...
        [lines(k).point1(1) lines(k).point2(1)], ...
        [lines(k).point1(2) lines(k).point2(2)], ...
        'r','LineWidth',2);
end