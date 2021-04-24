function x = mydequant(q, w)
% Dequantizes the given input
%
% Parameters:
%   x - The input                               [Array]
%   w - The width of the quantization window    [Scalar]
%
% Return:
%   The quantization symbol [Array same size as input]

%% Checks
assert(isnumeric(q), "q is not numeric")
assert(all(q(:) == floor(q(:))), "q is not symbol (integer)")

assert(isnumeric(w), "w is not numeric")
assert(isscalar(w), "w is not scalar")

%% Code
x = (q+1/2).*w;

end

