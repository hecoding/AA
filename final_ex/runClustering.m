function runClustering(path, X)
%Each row must be an example
oldpwd = cd (path);

K = 4;
initial_centroids = X(randperm(size(X, 1), K), :);
max_iters = 200;
plot_progress = false;
show_num_ex = 100;

[centroids, idx] = runkMeans(X, initial_centroids, max_iters, plot_progress);
%save centroids.mat centroids;
%save idx.mat idx;

for i = 1:size(centroids,1)
  %figure;
  %imshow(reshape( centroids (i,:) ,60,64));
  %title(sprintf("Centroid %i", i), 'fontsize', 12);
end

for i = 1:size(centroids,1)
  Xcluster = X(find(idx == i),:);
  %Xcluster = X(find(findClosestCentroids(X, centroids) == i),:);
  m = size(Xcluster, 1);
  if (m < show_num_ex)
    show_n = m;
  else show_n = show_num_ex;
  end
  rand_indices = randperm(m);
  sel = Xcluster(rand_indices(1:show_n), :);
  
  figure;
  displayData(sel, 64);
  title(sprintf("Cluster %i", i), 'fontsize', 12);
end

% show hit percentages

cd (oldpwd);
end
