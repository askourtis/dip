function xrgbres = myresize(xrgb, N, M, method)
% Resizes the given image
%
% Parameters:
%   xrgb   - The image to resize               [Array H-by-W-by-3]
%   N      - The new height                    [Scalar]
%   M      - The new width                     [Scalar]
%   method - The method to calculate the color [String]
%
% Return:
%   The new RGB image [Array N-by-M]

%% Checks
assert(isnumeric(xrgb), "xrgb is not numeric")
assert(ndims(xrgb) == 3, "xrgb is not image (ndims is not 3)")
assert(size(xrgb, 3) == 3, "xrgb is not RGB image (3rd dimension size is not 3)")

assert(isscalar(N), "N is not scalar")
assert(isnumeric(N), "N is not numeric")
assert(N == floor(N), "N should be an integer")

assert(isscalar(M), "M is not scalar")
assert(isnumeric(M), "M is not numeric")
assert(M == floor(M), "M should be an integer")

assert(isstring(method), "method should be a string")
assert(any(method == ["nearest" "linear"]), "method should be 'nearest' or 'linear'")

%% Code
% Linearly spaced vector from 1 to H with N data points
I = linspace(1, size(xrgb, 1), N);
% Linearly spaced vector from 1 to W with M data points
J = linspace(1, size(xrgb, 2), M);

if method == "nearest"
    % Round to nearest integer and sub-sample the original image
    xrgbres = xrgb(round(I), round(J), :);
else
    % Calculate Upper Row Index
    UI = floor(I);
    % Calculate Lower Row Index
    LI = ceil(I);
    
    % Calculate Leftmost Column Index
    UJ = floor(J);
    % Calculate Rightmost Column Index
    LJ = ceil(J);
    
    
    % Initialize output
    xrgbres = xrgb;
    % size(xrgbres) = [H W 3]
    
    % Row-wise interpolate all values between Upper and Lower row
    xrgbres = interpolate(I, UI, LI, xrgbres(UI, :, :), xrgbres(LI, :, :), 1);
    % size(xrgbres) = [N W 3]
    
    % Column-wise interpolate all values between Leftmost and Rightmost columns
    xrgbres = interpolate(J, UJ, LJ, xrgbres(:, UJ, :), xrgbres(:, LJ, :), 2);
    % size(xrgbres) = [N M 3]
end
end