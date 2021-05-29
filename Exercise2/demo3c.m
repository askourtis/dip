load('dip_hw_2.mat')

%% Constants
% labels
L = {"d2a", "d2b"};
% images
C = {d2a, d2b};
% T1 and T2 for recursive algorithm
T1 = 5;
T2 = 0.79;

%% Code
for i = 1:length(C)
    % Unpack image from cell
    im = C{i};
    
    % Show the image
    figure()
    image(im)
    
    % Compute the affinity matrix for the image
    W = Image2Graph(im);
    
    % Get first 2 dimensions of the image
    S = size(im);
    S = S(1:(end-1));
    
    % Seed the random number generator for reproducability
    rng(1);
    
    % Call the recursive nCuts algorithm
    cI = recursiveNCuts(W, T1, T2);
    cI = reshape(cI, S);
    
    
    % Reshape the resulting clustering to the same dimensions as the
    % original image
    cI = reshape(cI, S);
    
    % Find the unique clusters
    uI = unique(cI);

    % Display it
    figure()
    image(cI);
    colormap(repmat((1:max(uI))'./max(uI), [1 3])); % grey scale map
    title(sprintf("nCuts T1=%d T2=%.2f (k=%d)\n" , T1, T2, length(uI)))
end


function cI = recursiveNCuts(W, T1, T2)
% Clusters the given Affinity matrix via the recursive nCuts algorithm
%
% Parameters:
%   W - The affinity matrix [Matrix NxN]
%   T1 - The minimum number of members in a single cluster
%   T2 - The maximum nCut metric allowed for a cluster
%
% Returns:
%   cI - The cluster label of each vector element in W


%% Checks
if ~(isnumeric(W) && ismatrix(W) && size(W,1) == size(W,2))
    error("W should be a square matrix of numbers")
end

if ~(isnumeric(T1) && isscalar(T1) && floor(T1) == T1)
    error("T1 should be a integer scalar")
end

if ~(isnumeric(T2) && isscalar(T2) && T2 > 0)
    error("T2 should be a positive scalar")
end

%% Code

% Binary cluster the affinity matrix
cI = myNCuts(W, 2);

% Find the unique labels of groups
I = unique(cI);

% Split the groups
A = (cI == I(1));
B = ~A;


% Check if clusters have enough elements
M = min(sum(A), sum(B));
if (M < T1)
	return
end

% Check if the nCut metric is small enough
N = calculateNcut(W , cI);
if (N > T2)
	return
end


% Select all entries in the affinity matrix that belong in group A
WA = W(A, A);
% Replace all labels of the A group with the results of the next recursion
% The new labels must be 2*L + L' so that they wont colide with the
% previous labeling, or the labeling of B group
cI(A) = 2*I(1) + recursiveNCuts(WA, T1, T2);


% Select all entries in the affinity matrix that belong in group B
WB = W(B, B);
% Replace all labels of the B group with the results of the next recursion
% The new labels must be 2*L + L' so that they wont colide with the
% previous labeling, or the labeling of A group
cI(B) = 2*I(2) + recursiveNCuts(WB, T1, T2);
end