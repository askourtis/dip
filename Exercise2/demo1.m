load('dip_hw_2.mat')

% The affinity matrix is the d1a matrix from the loaded data
W = d1a;

% Calculate the relative possition of the original points assuming that W
% is their similarity matrix
Y = cmdscale(W./max(W));

% Plot the original points
figure()
plot(Y(:, 1), Y(:, 2), 'o', ...
            'MarkerSize', 10, ...
            'MarkerFaceColor', [0 0 0]);
title("Original points")
xlabel("x")
ylabel("y")
grid on


% For k = [2 3 4]
for k = 2:4
    % Seed the random generator with 1 for reproducability
    rng(1);
    
    % Cluster based on the given affinity matrix and produce k clusters
    cI = mySpectralClustering(W, k);
    
    % Find the unique cluster labels
    uI = unique(cI);
    
    % Create a color map for all the labels
    cmap = ones([max(uI) 3]);
    cmap(:, 1) = (1:max(uI))./max(uI);
    cmap = hsv2rgb(cmap);
    
    % Create a figure
    figure()
    % For each cluster label j
    for j = uI'
        % Find what points are part of the given cluster j
        I = (cI == j);
        
        % Plot the points of the cluster with the appropriate color
        plot(Y(I, 1), Y(I, 2), 'o', ...
            'MarkerSize', 10, ...
            'MarkerFaceColor', cmap(j, :));
        hold on
    end
    title("Clustering with k="+k)
    xlabel("x")
    ylabel("y")
    legend("Cluster #" + uI)
    grid on
    hold off
    
end