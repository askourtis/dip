function nCV = calculateNcut(W , cI)
% Computes the NCut metric for an affinity matrix and a binary clustering
%
% Parameters:
%   W - The affinity matrix [Matrix NxN]
%   cI - The clustering
%
% Returns:
%   nCV - The nCut metrix

%% Checks
if ~(isnumeric(W) && ismatrix(W) && size(W,1) == size(W,2))
    error("W should be a square matrix of numbers")
end

if ~(length(cI) == size(W,1) && length(unique(cI)) <= 2)
    error("cI should have one dimansion of size same as one dimension of W and have only 2 unique values")
end

%% Code
I = unique(cI);

% Seperate the clusters
A = (cI == I(1));
B = ~A;

% return 2 - Nassoc
nCV = 2 - Nassoc(W, A, B);
end

function v = assoc(W, A, B)
v = sum(sum(W(A, B)));
end

function v = Nassoc(W, A, B)
V = 1:size(W,1); % All
v = assoc(W,A,A)/assoc(W,A,V) + assoc(W,B,B)/assoc(W,B,V);
end