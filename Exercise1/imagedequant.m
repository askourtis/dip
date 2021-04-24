function x = imagedequant(q, w1, w2, w3)
% Dequantizes the given image
%
% Parameters:
%   q  - The symbols                                                [Array NxKx3]
%   w1 - The width of the quantization window for the red channel   [Scalar]
%   w2 - The width of the quantization window for the green channel [Scalar]
%   w3 - The width of the quantization window for the blue channel  [Scalar]
%
% Return:
%   The dequantized image [Array same size as input]

%% Checks
assert(ndims(q) == 3, "q does not have 3 dimensions")
assert(size(q,3) == 3, "q is not an image array (last dim is not 3)")
assert(isnumeric(q), "x is not numeric")
assert(all(q(:) == floor(q(:))), "q is not symbol (integer)")

assert(isnumeric(w1), "w1 is not numeric")
assert(isscalar(w1), "w1 is not scalar")

assert(isnumeric(w2), "w2 is not numeric")
assert(isscalar(w2), "w2 is not scalar")

assert(isnumeric(w3), "w3 is not numeric")
assert(isscalar(w3), "w3 is not scalar")

%% Code
W = {w1 w2 w3};
x = zeros(size(q));
for k = 1:size(q, 3)
    x(:, :, k) = mydequant(q(:, :, k), W{k});
end

end

