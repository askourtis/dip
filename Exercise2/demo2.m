load('dip_hw_2.mat')

% For each image c
for c = {d2a, d2b}
    % Extract the image from the cell
    im = c{1};
    
    % Show the image
    figure()
    image(im)
    title("Original Image")
    
    % Convert image to affinity matrix
    W = Image2Graph(im);
    
    % Select first 2 dimensions
    S = size(im);
    S = S(1:(end-1));
    
    % For all k = [2 3 4]
    for k = 2:4
        
        % Seed the random number generator with 1 for reproducability
        rng(1);
        
        % Cluster based on the given affinity matrix and produce k clusters
        cI = mySpectralClustering(W, k);
        % Reshape to match image dimensions
        cI = reshape(cI, S);
        
        % Find the unique clusters
        uI = unique(cI);
        
        % Plot
        figure()
        image(cI);
        colormap(repmat((1:max(uI))'./max(uI), [1 3])); % grey scale map
        title("Clustering with k="+k)
    end
end

