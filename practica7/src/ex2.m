A = double(imread('bird_small.png'));
A = A / 255;
imagesc(A);

X = reshape(A, size(A,1) * size(A,2), 3);
K = 16;
initial_centroids = X(randperm(size(X, 1), K), :);
max_iters = 10;
plot_progress = false;

[centroids, idx] = runkMeans(X, initial_centroids, max_iters, plot_progress);

idx = findClosestCentroids(X, centroids);
X_compressed = centroids(idx,:);

X_compressed = reshape(X_compressed, size(A, 1), size(A, 2), size(A, 3));

figure;
imagesc(X_compressed);
