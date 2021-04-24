%% Load Data
load('march.mat')

%% Constants
N = 150;
M = 200;

qb = 3;
W  = 1/2^qb;

filename = "dip_is_fun.ppm";

%% Demosaic
im = bayer2rgb(x);

%% Resize images
imr = myresize(im, N, M, "linear");

%% Quantize
ims = imagequant(imr, W, W, W);

%% Save as
saveasppm(ims, filename, 1/W);

%% Display
figure(1)
imshow(imagedequant(ims, W, W, W))
title('Localy dequantized image')

figure(2)
imshow(imread(convertStringsToChars(filename)))
title('P6 protocol image')