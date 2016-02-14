function idx = findClosestCentroids(X, centroids)
% X and centroids examples must be row vectors
m = size(X,1);
idx = zeros(m, 1);

for i = 1:m
  % take the index of the min distance of all the centroids to the point
  [d ix] = min(norm(X(i,:) - centroids, 2, 'rows'));
  idx(i) = ix;
end

end
