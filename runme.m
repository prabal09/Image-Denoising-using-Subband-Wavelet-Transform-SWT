global global_rows
global_rows = 512;
global global_columns
global_columns = 512;
global filter_taps
filter_taps = 9;
global delay
delay = 5;

%%/* Storage for main program */
global h1
h1 = zeros(9,1);
global g1
g1 = zeros(9,1);
global g2
g2 = zeros(9,1);
X = zeros(global_rows,global_columns);
Y = zeros(global_rows,global_columns);

h1(1) = 0.026749;           g2(9) = -h1(1); 
h1(2) = -0.016864;          g2(8) = h1(2);
h1(3) = -0.078223;          g2(7) = -h1(3);
h1(4) = 0.266864;           g2(6) = h1(4);
h1(5) = 0.602949;           g2(5) = -h1(5);
h1(6) = 0.266864;           g2(4) = h1(6);
h1(7) = -0.078223;          g2(3) = -h1(7);
h1(8) = -0.016864;          g2(2) = h1(8);
h1(9) = 0.026749;           g2(1) = -h1(9);
global h2
%h2 = zeros(9,1);
h2(1) = 0.0;                g1(9) = -h2(1);
h2(2) = -0.045636;          g1(8) = h2(2);
h2(3) = -0.028772;          g1(7) = -h2(3);
h2(4) = 0.295636;           g1(6) = h2(4);
h2(5) = 0.557543;           g1(5) = -h2(4);
h2(6) = 0.295636;           g1(4) = h2(4);
h2(7) = -0.028772;          g1(3) = h2(4);
h2(8) = -0.045636;          g1(2) = h2(4);
h2(9) = 0.0;                g1(1) = h2(4);

h1 = h1*(2)^0.5;
g1 = g1*(2)^0.5;
h2 = h2*(2)^0.5;
g2 = g2*(2)^0.5;
image = 'lena512noisy.bmp';
imshow(imread(image))
title('lenaNoisy')
F=fft2(imread(image), 256,256);
F2=fftshift(F);       
figure,imshow(log(1+abs(F2)),[])
title('FFT lenaNoisy')
p3 = mod_pyramid3(image,3);
F=fft2(p3, 256,256);
F2=fftshift(F);       
figure,imshow(log(1+abs(F2)),[])
title('FFT mod pyramid:3 subband set to 0')
p10 = mod_pyramid3(image,10);
F=fft2(p10, 256,256);
F2=fftshift(F);       
figure,imshow(log(1+abs(F2)),[])
title('FFT mod pyramid:10 subband set to 0')
p15 = mod_pyramid3(image,15);
F=fft2(p15, 256,256);
F2=fftshift(F);       
figure,imshow(log(1+abs(F2)),[])
title('FFT mod pyramid:15 subband set to 0')

d1 = band16_2(image,1);
F=fft2(d1, 256,256);
F2=fftshift(F);       
figure,imshow(log(1+abs(F2)),[])
title('FFT pyramid:1 subband set to 0')
d3 = band16_2(image,3);
F=fft2(d3, 256,256);
F2=fftshift(F);       
figure,imshow(log(1+abs(F2)),[])
title('FFT pyramid:3 subband set to 0')
d6 = band16_2(image,6);
F=fft2(p15, 256,256);
F2=fftshift(F);       
figure,imshow(log(1+abs(F2)),[])
title('FFT pyramid:6 subband set to 0')