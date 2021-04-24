function V = interpolate(X, X1, X2, V1, V2, D)
% Estimates a value given an input, input-boundaries and value-bandaries
%
% Parameters:
%   X  - The input                      [Vector  length N ]
%   X1 - An input-boundary              [Vector  length N ]
%   X2 - An input-boundary              [Vector  length N ]
%   V1 - The value-boundary for X1      [Array   ...xNx...]
%   V2 - The value-boundary for X2      [Array   size(V1) ]
%   D  - The dimension to interpolate   [Scalar           ]
%
% Return:
%   An estimation for V [Array size(V1)]


%% Checks
assert(isnumeric(X), "X is not numeric")
assert(isvector(X), "X is not vector")

assert(isnumeric(X1), "X1 is not numeric")
assert(isvector(X1), "X1 is not vector")
assert(length(X1) == length(X), "X1 is not of same length as X")

assert(isnumeric(X2), "X2 is not numeric")
assert(isvector(X2), "X2 is not vector")
assert(length(X2) == length(X), "X2 is not of same length as X")

assert(isnumeric(V1), "V1 is not numeric")
assert(ndims(V1) > D, "V1 dimensions is smaller than D")
assert(size(V1, D) == length(X), "V1 D-th dimention is not the same size as length of X")

assert(isnumeric(V2), "V2 is not numeric")
assert(ndims(V2) == ndims(V1), "V2 and V1 do not have the same number of dimensions")
assert(all(size(V1) == size(V2)), "V2 and V1 are not of same size")


%% Code

% Remove dimensions from inputs
X  = X(:);
X1 = X1(:);
X2 = X2(:);

% Permutation to apply after repmat as to match dimensions
P = circshift(1:ndims(V1), D-1);

% How to repeat the matrix to match dimensions
% Bring the dimension of the interpolation to first place in the matrix
R = circshift(size(V1), 1-D);
% Set it to one
R(1) = 1;

% Calculate the scaling for the interpolation at each input point
A = (X2 - X)./(X2 - X1);
% If X1 == X2 then A is NaN, In this case V = (V1 + V2)/2;
A(isnan(A)) = 1/2;
% Repeat the resulting matrix to match dimensions of V
A = repmat(A, R);
% Permute the resulting matrix to match dimensions of V
A = permute(A, P);

% Interpolate
V = A.*V1 + (1-A).*V2;
end