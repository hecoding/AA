function [bestLambda bestTime] = plotLambda(lambdas, Xtrain, ytrain, Xvalidation, yvalidation, num_labels, normalization, scale = 'decimal')
% given a vector of sizes, this function trains a neural network for each one
% and computes the error of the prediction over the training and validation data
% then plots it. The examples of Xtrain and Xval must be row vectors.

if(strcmp(normalization, 'normalization'))
  save_train_name = 'lambda_train_norm.mat';
  save_val_name = 'lambda_val_norm.mat';
  disp('With normalization:');
else
  save_train_name = 'lambda_train.mat';
  save_val_name = 'lambda_val.mat';
end

if(exist(save_train_name, 'file') == 2 && exist(save_val_name, 'file') == 2)
  load(save_train_name);
  load(save_val_name);
else
  
  lambda_train = zeros(length(lambdas),1);
  lambda_val = zeros(length(lambdas),1);
  times = zeros(length(lambdas),1);

  for i = 1:length(lambdas)
    lambda = lambdas(i);
    
    tic();
    thetas = oneVsAll(Xtrain, ytrain, num_labels, lambda);
    times(i) = toc();
    
    lambda_train(i) = newCost(thetas, Xtrain, ytrain, lambda);
    lambda_val(i)   = newCost(thetas, Xvalidation, yvalidation, lambda);
  end
  save(save_train_name, 'lambda_train');
  save(save_val_name, 'lambda_val');
  save('lambda_times', 'times');
end

% filter NaNs to plot properly
for i = 1:length(lambda_train)
  if(isnan(lambda_train(i)))
    lambda_train(i) = 0;
  end
end

for i = 1:length(lambda_val)
  if(isnan(lambda_val(i)))
    lambda_val(i) = 0;
  end
end

figure;
hold on;
plot(lambdas, lambda_train);
plot(lambdas, lambda_val, 'g');
xlabel('\lambda', 'fontsize', 10);
ylabel('Error', 'fontsize', 10);
legend('training', 'cross validation');
legend('boxoff');
title('Learning curve: error vs lambdas', 'fontsize', 12);
if(strcmp(scale, 'logscale'))
  set(gca, 'xscale', 'log');
end
hold off;

[tmp bestLambdaIdx] = min(lambda_val);
bestLambda = lambdas(bestLambdaIdx);
bestTime = times(bestLambdaIdx);

end