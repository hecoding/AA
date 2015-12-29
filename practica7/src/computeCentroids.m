function centroids = computeCentroids(X, idx, K)
% Each example of X must be a row vector
centroids = zeros(K, size(X, 2));

for i = 1:K
  indices = idx == i;
  centroids(i,:) = mean(X(indices,:));
end

end
