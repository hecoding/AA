function Z = compressData(Ureduce, X, mean, deviation)
% each example must be a column of the X matrix

% mean normalization because feature scaling is not needed for this examples
X_norm = bsxfun(@minus, X, mean);
X_norm = bsxfun(@rdivide, X_norm, deviation);

% you can do feature scaling here if needed

Z = Ureduce' * X_norm;

end
