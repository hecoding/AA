function [bestLambda bestTime bestPercentage] = ...
         plotPercentage(lambdas, Xtrain, ytrain, Xval, yval, num_hidden_neurons, num_labels, num_iter, normalization, scale = 'decimal')
% given a vector of sizes, this function trains a neural network for each one
% and computes the error of the prediction over the training and validation data
% then plots it. The examples of Xtrain and Xval must be row vectors.

if(strcmp(normalization, 'normalization'))
  save_name = 'percentage_norm.mat';
else
  save_name = 'percentage.mat';
end

if(exist(save_name, 'file') == 2)
  load(save_name);
else
  
  lambda_train = zeros(length(lambdas),1);
  lambda_val = zeros(length(lambdas),1);
  times = zeros(length(lambdas),1);

  for i = 1:length(lambdas)
    lambda = lambdas(i);
    
    tic();
    [hits thetas] = runNN(Xtrain, ytrain, num_hidden_neurons, num_labels, num_iter, lambda);
    times(i) = toc();
    
    lambda_train(i) = forwardProp(thetas, size(Xtrain,2), num_hidden_neurons, num_labels , Xtrain, ytrain);
    lambda_val(i) = forwardProp(thetas, size(Xtrain,2), num_hidden_neurons, num_labels , Xval, yval);
  end
  save(save_name, 'lambda_train', 'lambda_val', 'times');
end

% filter NaNs to plot properly
for i = 1:length(lambda_train)
  if(isnan(lambda_train(i)) || isinf(lambda_train(i)))
    lambda_train(i) = 0;
  end
end

for i = 1:length(lambda_val)
  if(isnan(lambda_val(i)) || isinf(lambda_val(i)))
    lambda_val(i) = 0;
  end
end

figure;
hold on;
plot(lambdas, lambda_train);
plot(lambdas, lambda_val, 'g');
xlabel('\lambda', 'fontsize', 10);
ylabel('% hits', 'fontsize', 10);
legend('training', 'cross validation');
legend('boxoff');
title(cstrcat('Learning curve: hits vs lambdas. ', normalization), 'fontsize', 12, 'interpreter', 'none');
if(strcmp(scale, 'logscale'))
  set(gca, 'xscale', 'log');
end
hold off;

[bestPercentage bestLambdaIdx] = max(lambda_val);
bestLambda = lambdas(bestLambdaIdx);
bestTime = times(bestLambdaIdx);

end