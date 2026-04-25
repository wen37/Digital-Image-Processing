clear;clc;close all;
cd(fileparts(mfilename('fullpath')));

%边缘检测部分
srcImage=imread('lenna.jpg');%加载图片并读取图片信息
grayImage=rgb2gray(srcImage);%转换为灰度图像

%分别用Sobel、Prewitt、Log、Canny算子进行边缘检测
imageSobel=edge(grayImage,'sobel');
imagePrewitt=edge(grayImage,'prewitt');
imageLog=edge(grayImage,'log');
imageCanny=edge(grayImage,'canny');

%显示检测图像
figure(1);subplot(2,3,1);imshow(srcImage);title('Original Image')
figure(1);subplot(2,3,2);imshow(grayImage);title('Gray Image');
figure(1);subplot(2,3,3);imshow(imageSobel);title('sobel');
figure(1);subplot(2,3,4);imshow(imagePrewitt);title('prewitt');
figure(1);subplot(2,3,5);imshow(imageLog);title('log');
figure(1);subplot(2,3,6);imshow(imageCanny);title('canny');

%图像分割部分
clear;
srcImage1=imread('lenna.jpg');
figure(2);subplot(2,2,1);imshow(srcImage1);title('Original Image');
%固定阈值T
T=100;
level=T/255;
grayImage1=rgb2gray(srcImage1);
figure(2);subplot(2,2,2);imshow(grayImage1);title('Gray Image');
%二值化阈值分割
bw=imbinarize(grayImage1,level);
figure(2);subplot(2,2,3);imshow(bw);title('T=100');

%迭代式阈值分割
zmax=max(max(grayImage1));%取出灰度最大值
zmin=min(min(grayImage1));%取出灰度最小值
tk=(zmax+zmin)/2;%初始阈值
bcal=1;[m,n]=size(grayImage1);
while(bcal)
    %定义前景和背景数
    iforeground=0;
    ibackground=0;
    %定义前景和背景灰度总和
    foregroundsum=0;
    backgroundsum=0;
    for i=1:m
        for j=1:n
            tmp=grayImage1(i,j);
            if(tmp>=tk)
                %前景灰度值
                iforeground=iforeground+1;
                foregroundsum=foregroundsum+double(tmp);
            else
                ibackground=ibackground+1;
                backgroundsum=backgroundsum+double(tmp);
            end
        end
    end
    %计算前景和背景的平均值
    z1=foregroundsum/iforeground;
    z2=backgroundsum/ibackground;
    tktmp=uint8((z1+z2)/2);%新的阈值
    if(tktmp==tk)
        bcal=0;%bcal是一个布尔变量，为假(0)时，迭代结束
    else
        tk=tktmp;
    end
    %当阈值不再变化时，说明迭代结束
end
%在command window(命令行窗口)里显示出：迭代的阈值：阈值
disp(strcat('迭代的阈值：',num2str(tk)));
%strcat()函数可以将多个字符串连在一起，num2str()指将括号内的数值转换为字符串
newI=imbinarize(grayImage1,double(tk)/255);
%函数imbinarize使用阈值（threshold）变换法把灰度图像进行阈值分割
figure(2);subplot(2,2,4);imshow(newI);title('迭代分割');