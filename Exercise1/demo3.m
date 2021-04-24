%% Load Data
load('march.mat')

%% Constants
qb = 3;
W  = 1/2^qb;

%% Resize images
im = bayer2rgb(x);

% Calculate image symbols
ims = imagequant(im, W, W, W);
% Dequantize from symbols
imq = imagedequant(ims, W, W, W);

%% Display images
figure(1)
imshow(im)
title('Original image')

figure(2)
imshow(imq)
title(sprintf('Image quantized with %d bits', qb))