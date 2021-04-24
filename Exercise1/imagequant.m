function q = imagequant(x, w1, w2, w3)
% Quantizes the given image
%
% Parameters:
%   x  - The image                                                  [Array NxKx3]
%   w1 - The width of the quantization window for the red channel   [Scalar]
%   w2 - The width of the quantization window for the green channel [Scalar]
%   w3 - The width of the quantization window for the blue channel  [Scalar]
%
% Return:
%   The quantization symbol [Array same size as input]

%% Checks
assert(ndims(x) == 3, "x does not have 3 dimensions")
assert(size(x,3) == 3, "x is not an image array (last dim is not 3)")
assert(isnumeric(x), "x is not numeric")

assert(isnumeric(w1), "w1 is not numeric")
assert(isscalar(w1), "w1 is not scalar")

assert(isnumeric(w2), "w2 is not numeric")
assert(isscalar(w2), "w2 is not scalar")

assert(isnumeric(w3), "w3 is not numeric")
assert(isscalar(w3), "w3 is not scalar")

%% Code
W = {w1 w2 w3};
q = zeros(size(x));
for k = 1:3
    % quantize the given channel with the correct zone width
    tq = myquant(x(:, :, k), W{k});
    % Since the brightness is in [0, 1], the corner case of 1 will be its
    % own quantization symbol which is wasteful.
    % Brightness of one is considered to be part of the previous
    % quantization zone
    tq(x(:, :, k) >= 1) = 1/W{k} - 1;
    q(:, :, k) = tq;
end

end

