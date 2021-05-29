function cI = mySpectralClustering(W, k)
% Clusters an affinity matrix based on value similarity
%
% Parameters:
%   W - The affinity matrix [Matrix NxN]
%   k - Number or clusters to produce
%
% Returns:
%   cI - The cluster label of each vector element in W


%% Checks
if ~(isnumeric(W) && ismatrix(W) && size(W,1) == size(W,2))
    error("W should be a square matrix of numbers")
end

if ~(isnumeric(k) && isscalar(k) && floor(k) == k)
    error("k should be a integer scalar")
end


%% Code
% Sum up all of the colums of W and create a diagonal matrix of the
% resulting vector
D = diag(sum(W, 2));

% Calculating the laplacian L
L = D - W;

% Compute the k smallest laplacians eigenvectors
[V, ~] = eigs(L, k, 'smallestreal');

% Apply kmeans on those
cI = kmeans(V, k);

end

