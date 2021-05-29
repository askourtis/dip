function AMAT = Image2Graph(IM)
% Converts an image its affinity matrix
%
% Parameters:
%   IM - The image input [NDArray NxMx3]
%
% Returns:
%   A - The affinity matrix [Matrix NMxNM]
%           A(i,j) = exp(-D(i,j))
%           D(i,j) = distance of pixel i to pixel j


%% Checks
if ~(isnumeric(IM) && ndims(IM) == 3 && size(IM, 3) == 3)
    error("IM should be a NDArray NxMx3 of doubles")
end

%% Code
D    = Image2Dist(IM);
AMAT = exp(-D);
end



function D = Image2Dist(IM)
% Converts an image to distance matrix
%
% Parameters:
%   IM - The image input [NDArray NxMx3]
%
% Returns:
%   D - The distance matrix [Matrix NMxNM]
%           D(i,j) = distance of pixel i to pixel j

%% Checks
if ~(isnumeric(IM) && ndims(IM) == 3 && size(IM, 3) == 3)
    error("IM should be a NDArray NxMx3 of doubles")
end

%% Code
% Extract dimension sizes
N = size(IM, 1);
M = size(IM, 2);
K = size(IM, 3);

% Reshape the image to column image of NM rows
X = reshape(IM, [N*M 1 K]);

% Comute its "Transpose"
Xt = permute(X, [2 1 3]);


% Compute all possible differences of each pixel with every other
DX = X-Xt;

% Raise all to 2
DX2 = DX.^2;

% Sum the last dimension (sum the single color channel differences)
D2 = sum(DX2,3);

% Apply sqrt to compute the euclidean distance of each pixel to every other
D = sqrt(D2);
end


