%% Load Data
load('march.mat')

%% Kernels for each color channel
K{1} = 1/4 .* [1 2 1;
               2 4 2;
               1 2 1];

K{2} = 1/4 .* [0 1 0;
               1 4 1;
               0 1 0];
           
K{3} = K{1};


%% Display kernels
N = {'RED', 'GREEN', 'BLUE'};
for i = 1:3
    figure(i)
    image(repmat(K{i},[1 1 3]))
    title(sprintf('%s kernel', N{i}))
end

%% Display image
figure(i+1)
imshow(bayer2rgb(x))
title('Resulting image')
