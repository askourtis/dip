%% Load Data
load('march.mat')

%% Resize images
im = bayer2rgb(x);

imn = myresize(im, 240, 320, "nearest");
iml = myresize(im, 200, 300, "linear");


%% Display images
figure(1)
imshow(im)
title('Original image')

figure(2)
imshow(imn)
title('Nearest method image')

figure(3)
imshow(iml)
title('Bilinear interpolation method image')