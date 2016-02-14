function [X_norm mean deviation] = preprocessData(X)
% each example must be a column of the X matrix

if(exist('prediction_data.mat', 'file') == 2)
  load('prediction_data.mat');
else
  mean = mean(X, 2);
  deviation = std(X, 0, 2);
  save prediction_data.mat mean deviation;
end

% mean normalization because feature scaling is not needed for these examples
X_norm = bsxfun(@minus, X, mean);
X_norm = bsxfun(@rdivide, X_norm, deviation);

% you can do feature scaling here if needed

end