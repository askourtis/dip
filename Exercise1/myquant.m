function q = myquant(x, w)
% Quantizes the given input
%
% Parameters:
%   x - The input                               [Array]
%   w - The width of the quantization window    [Scalar]
%
% Return:
%   The quantization symbol [Array same size as input]

%% Checks
assert(isnumeric(x), "x is not numeric")

assert(isnumeric(w), "w is not numeric")
assert(isscalar(w), "w is not scalar")

%% Code
q = floor(x./w);


end

