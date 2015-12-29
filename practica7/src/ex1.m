load('ex7data2.mat');
K = 3;
%initial_centroids = [3 3; 6 2; 8 5];
initial_centroids = X(randperm(size(X, 1), K), :);
max_iters = 10;
plot_progress = true;

runkMeans(X, initial_centroids, max_iters, plot_progress);
