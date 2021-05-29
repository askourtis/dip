load('dip_hw_2.mat')

%% Constants
% labels
L = {"d2a", "d2b"};
% images
C = {d2a, d2b};

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
    
    % Run nCuts Recursive Clustering only for the first level
    % So, just split the image into 2 groups
    cI = myNCuts(W, 2);
    
    % Calculate the nCut metric and display it 
    nCV = calculateNcut(W , cI);
    fprintf("nCut for %s is %d\n", L{i}, nCV)
    
    % Reshape the resulting clustering to the same dimensions as the
    % original image
    cI = reshape(cI, S);
    
    % Find the unique clusters
    uI = unique(cI);
    
    % Display it
    figure()
    image(cI);
    colormap(repmat((1:max(uI))'./max(uI), [1 3])); % grey scale map
    title("Clustering with k=2 of " + L{i})
end