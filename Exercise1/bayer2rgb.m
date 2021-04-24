function xrgb = bayer2rgb(xb)
% Converts a bayer raster to RGB image
%
% Parameters:
%   xb - The bayer raster                              [Array Í-by-M]
%
% Return:
%   The RGB image                                      [Array N-by-M-by-3]

%% Checks
assert(isnumeric(xb), "xb is not numeric")
assert(ismatrix(xb),  "xb is not matrix")
assert(all(mod(size(xb), 2) == 0), "xb size should be divisible by 2")

%% Code
% Sampling stencils for each channel
% RED PATTERN
% 0 0
% 1 0
I(:, :, 1) = logical(repmat([0 0; 1 0], ceil(size(xb)/2)));
% GREEN PATTERN
% 1 0
% 0 1
I(:, :, 2) = logical(repmat([1 0; 0 1], ceil(size(xb)/2)));
% BLUE PATTERN
% 0 1
% 0 0
I(:, :, 3) = logical(repmat([0 1; 0 0], ceil(size(xb)/2)));

% Initialize output to be of size NxMx3
xrgb = zeros([size(xb) 3]);
% xb3 = [xb xb xb] in 3rd dimension
xb3 = repmat(xb, [1 1 3]);
% Each color channel has the correct sampling information from the original
xrgb(I) = xb3(I);


% Each color channel should have its own interpolate kernel
K{1} = 1/4 .* [1 2 1;
               2 4 2;
               1 2 1];

K{2} = 1/4 .* [0 1 0;
               1 4 1;
               0 1 0];
           
K{3} = K{1};

% For each color channel
for i = 1:3
    % Convolve to interpolate the color channel
    xrgb(:, :, i) = conv2(xrgb(:, :, i), K{i}, "same");
end

end