function feat = addFeatures(X, p)
% X is a column vector
m = size(X, 1);
feat = zeros(m, p);

for i = 1:p
  feat(:,i) = X .^ i;
end

end