load('ex6data3.mat');

nums = [0.01, 0.03, 0.1, 0.3, 1, 3, 10, 30];
% compute variations with repetition
vars = unique(nchoosek(repmat(nums,1,2),2),'rows');
% vector with the percentage of hits of each model
percentages = zeros(size(vars), 1);

for i = 1:size(vars, 1)
  C = vars(i, 1);
  sigma = vars(i, 2);
  
  model = svmTrain(X, y, C, @(x1, x2) gaussianKernel(x1, x2, sigma));
  
  pred = svmPredict(model, Xval);
  percentages(i) = mean(double(pred == yval)) * 100;
end

% print a 3D plot or something nice
