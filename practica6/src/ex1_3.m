load('ex6data3.mat');

nums = [0.01, 0.03, 0.1, 0.3, 1, 3, 10, 30];
% compute variations with repetition
vars = unique(nchoosek(repmat(nums,1,2),2),'rows');
% vector with the percentage of hits of each model
percentages = zeros(size(vars), 1);
elapsed_time = zeros(size(vars), 1);

for i = 1:size(vars, 1)
  C = vars(i, 1);
  sigma = vars(i, 2);
  
  tic();
  model = svmTrain(X, y, C, @(x1, x2) gaussianKernel(x1, x2, sigma));
  elapsed_time(i) = toc();
  
  pred = svmPredict(model, Xval);
  percentages(i) = mean(double(pred == yval)) * 100;
end

% size and color are relative. bigger (or colder) means less time to compute
scatter3(vars(:,1), vars(:,2), percentages,...
         1.2*(max(elapsed_time) - elapsed_time), elapsed_time, '.');
box on;
set(gca, 'xscale', 'log');
set(gca, 'yscale', 'log');
xlabel('C');
ylabel('\sigma');
zlabel('% of hits');
