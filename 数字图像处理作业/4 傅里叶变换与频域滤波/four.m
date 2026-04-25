clc;clear;close all; 
cd(fileparts(mfilename('fullpath')));

grayimg=imread('camera.png'); %读取灰度图像
grayimg=im2double(grayimg); % 图像数据类型转换 
 
f=fft2(grayimg); % FFT 傅里叶变换 f 是一个复数 
f_shift=fftshift(f); % shift 将变换的频率图像四角移动到中心 
 
subplot(3,3,1),imshow(grayimg),title('original img'); 
subplot(3,3,2),imshow(log(abs(f)+1),[]),title('FFT before shift'); 
subplot(3,3,3),imshow(log(abs(f_shift)+1),[]),title('FFT after shift'); 
 
[m,n]=size(f_shift); 
m_mid=fix(m/2); 
n_mid=fix(n/2); 
 
% 理想低通滤波
l=zeros(m,n); 
d0=50; 
for i=1:m
    for j=1:n
        d=sqrt((i-m_mid)^2+(j-n_mid)^2);
        if d<=d0
            l(i,j)=1;
        end
    end
end
img_lpf=l.*f_shift; 
img_lpf=ifftshift(img_lpf); 
img_lpf=ifft2(img_lpf); 
img_lpf=real(img_lpf); 
subplot(3,3,4);imshow(l);title('ideal low pass filter'); 
subplot(3,3,7);imshow(img_lpf);title('ideal LPF filtered image'); 

% 巴特沃兹低通滤波
l2=zeros(m,n); 
d2=50; 
N=2; 
for i=1:m
    for j=1:n
        d=sqrt((i-m_mid)^2+(j-n_mid)^2);
        l2(i,j)=1/(1+(d/d2)^(2*N));
    end
end
img_blpf=l2.*f_shift; 
img_blpf=ifftshift(img_blpf); 
img_blpf=ifft2(img_blpf); 
img_blpf=real(img_blpf); 
subplot(3,3,6);imshow(l2);title('BLPF filter'); 
subplot(3,3,9);imshow(img_blpf);title('BLPF filtered image');