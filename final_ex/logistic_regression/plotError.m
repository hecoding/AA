function plotError(sizes, Xtrain, ytrain, Xval, yval, num_labels, lambda, normalization, scale = 'decimal')
% given a vector of sizes, this function trains a neural network for each one
% and computes the error of the prediction over the training and validation data
% then plots it. The examples of Xtrain and Xval must be row vectors.

if(strcmp(normalization, 'normalization'))
  save_train_name = 'error_train_norm.mat';
  save_val_name = 'error_val_norm.mat';
  disp('With normalization:');
else
  save_train_name = 'error_train.mat';
  save_val_name = 'error_val.mat';
end

if(exist(save_train_name, 'file') == 2 && exist(save_val_name, 'file') == 2)
  load(save_train_name);
  load(save_val_name);
else
  
  error_train = zeros(length(sizes),1);
  error_val = zeros(length(sizes),1);

  for i = 1:length(sizes)
    xsettrain = Xtrain(1:sizes(i),:);
    ysettrain = ytrain(1:sizes(i));
    
    thetas = oneVsAll(xsettrain, ysettrain, num_labels, lambda);

    error_train(i) = newCost(thetas, xsettrain, ysettrain, lambda);
    error_val(i)   = newCost(thetas, Xval, yval, lambda);
  end
  save(save_train_name, 'error_train');
  save(save_val_name, 'error_val');
end

% filter NaNs to plot properly
for i = 1:length(error_train)
  if(isnan(error_train(i)))
    error_train(i) = 0;
  end
end

for i = 1:length(error_val)
  if(isnan(error_val(i)))
    error_val(i) = 0;
  end
end

figure;
hold on;
plot(sizes, error_train);
plot(sizes, error_val, 'g');
xlabel('# training examples', 'fontsize', 10);
ylabel('Error', 'fontsize', 10);
legend('training', 'cross validation');
legend('boxoff');
title(cstrcat('Learning curve: error vs num examples. \lambda = ', num2str(lambda)), 'fontsize', 12);
if(strcmp(scale, 'logscale'))
  set(gca, 'xscale', 'log');
end
hold off;

end