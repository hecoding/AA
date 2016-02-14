function runSVMTraining(path, trainSet, ytrainSet, validationSet, yvalidationSet, testSet, ytestSet, normalization = 'normalization')

oldpwd = cd (path);

if(strcmp(normalization, 'normalization'))
  save_name = 'training_norm.mat';
  disp('WITH DATA NORMALIZATION:');
  trainSet = (featureNormalize(trainSet'))';
  validationSet = (featureNormalize(validationSet'))';
  testSet = (featureNormalize(testSet'))';
else
  save_name = 'training.mat';
  disp('WITHOUT DATA NORMALIZATION:');
end

% coeficients to use with C and sigma (gaussian kernel) parameters
nums = [0.01, 0.03, 0.1, 0.3, 1, 3, 10, 30];

if(exist(save_name, 'file') == 2)
  load(save_name);
else

  % firstly we'll try with a linear kernel
  %   vector with the percentage of hits of each model
  percentages_linear = zeros(length(nums), 1);
  elapsed_time_linear = zeros(length(nums), 1);
  best_linear_percentage = 0;

  for i = 1:length(nums)
    C = nums(i);
    C
    tic();
    model = trainOneVsAll(trainSet, ytrainSet, C, @(x1, x2) linearKernel(x1, x2));
    elapsed_time_linear(i) = toc();
    
    pred = predictOneVsAll(model, validationSet);
    percentages_linear(i) = computePercentageOneVsAll(pred, yvalidationSet);
    
    if(percentages_linear(i) > best_linear_percentage)
      best_linear_model = model;
      best_linear_percentage = percentages_linear(i);
      best_linear_time = elapsed_time_linear(i);
    end
  end
  save (save_name, 'best_linear_model', 'percentages_linear', 'elapsed_time_linear', 'best_linear_percentage', 'best_linear_time');
end

% performance plot
figure;
hold on;
plot(nums, percentages_linear);
scatter(nums, percentages_linear, 0.3 * elapsed_time_linear, elapsed_time_linear, 'filled');
set(gca, 'xscale', 'log'); % because parameters are in logscale
xlabel('C');
ylabel('% of hits');
hold off;

disp('LINEAR KERNEL');
[temp idx] = max(percentages_linear);
printf('Best regularization parameter: %d\n', nums(idx));
printf('Hits on validation set: %d%%\n', best_linear_percentage);
printf('Time to train best percentage model: %ds\n', best_linear_time);

% test with the most succesful model
pred = predictOneVsAll(best_linear_model, testSet);
[per classes precision recall] = computePercentageOneVsAll(pred, ytestSet);

printf('\nHits on test set: %d%%\n\n', per);

for i = 1:length(classes)
  printf('Hits on class %i: %d%%\n', i, classes(i));
end

printf('Precision: %d\n', precision);
printf('Recall: %d\n', recall);
printf('Average: %d\n', (precision + recall)/2);
printf('F1 score: %d\n', 2 * ((precision * recall)/(precision + recall)));

%------------------------------------------------------------------
% now let's try with a gaussian kernel
%   compute variations with repetition
vars = unique(nchoosek(repmat(nums,1,2),2),'rows');
if(exist(strcat('gauss_', save_name), 'file') == 2)
  load(strcat('gauss_', save_name));
else
  %   vector with the percentage of hits of each model
  percentages_gauss = zeros(size(vars), 1);
  elapsed_time_gauss = zeros(size(vars), 1);
  highest_percentage_gauss = 0;

  for i = 1:size(vars, 1)
    C = vars(i, 1);
    sigma = vars(i, 2);
    C
    tic();
    model = trainOneVsAll(trainSet, ytrainSet, C, @(x1, x2) gaussianKernel(x1, x2, sigma));
    elapsed_time_gauss(i) = toc();
    
    pred = predictOneVsAll(model, validationSet);
    percentages_gauss(i) = computePercentageOneVsAll(pred, yvalidationSet);
    
    if(percentages_gauss(i) > highest_percentage_gauss)
      best_model_gauss = model;
      highest_percentage_gauss = percentages_gauss(i);
    end
  end
  save (strcat('gauss_', save_name), 'best_model_gauss', 'percentages_gauss', 'elapsed_time_gauss', 'highest_percentage_gauss');
end

figure;
scatter3(vars(:,1), vars(:,2), percentages_gauss, elapsed_time_gauss, elapsed_time_gauss, '.');
box on;
set(gca, 'xscale', 'log'); % because parameters are in logscale
set(gca, 'yscale', 'log'); % because parameters are in logscale
xlabel('C');
ylabel('\sigma');
zlabel('% of hits');

% test with the most succesful model
bestModelIndex = find(percentages_gauss == max(percentages_gauss));
C = vars(bestModelIndex(1), 1);
sigma = vars(bestModelIndex(1), 2);
model = trainOneVsAll(trainSet, ytrainSet, C, @(x1, x2) gaussianKernel(x1, x2, sigma));

disp('GAUSSIAN KERNEL');
[temp idx] = max(percentages_linear);
printf('Best regularization parameters: C = %d, sigma = %d\n', C, sigma);
printf('Hits on validation set: %d%%\n', highest_percentage_gauss);
printf('Time to train best percentage model: %ds\n', elapsed_time_gauss(bestModelIndex(1)));

% test with the most succesful model
pred = predictOneVsAll(model, testSet);
[per classes precision recall] = computePercentageOneVsAll(pred, ytestSet);

printf('\nHits on test set: %d%%\n\n', per);

for i = 1:length(classes)
  printf('Hits on class %i: %d%%\n', i, classes(i));
end

printf('Precision: %d\n', precision);
printf('Recall: %d\n', recall);
printf('Average: %d\n', (precision + recall)/2);
printf('F1 score: %d\n', 2 * ((precision * recall)/(precision + recall)));

cd (oldpwd);

end
