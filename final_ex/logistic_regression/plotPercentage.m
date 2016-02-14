function [bestLambda bestTime bestPercentage] = ...
         plotPercentage(lambdas, Xtrain, ytrain, Xvalidation, yvalidation, num_labels, normalization, scale = 'decimal')
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
    thetas = oneVsAll(Xtrain, ytrain, num_labels, lambda);
    times(i) = toc();
    
    lambda_train(i) = computePercentageOneVsAll(predict(Xtrain, thetas), ytrain);
    lambda_val(i)   = computePercentageOneVsAll(predict(Xvalidation, thetas), yvalidation);
  end
  save(save_name, 'lambda_train', 'lambda_val', 'times');
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