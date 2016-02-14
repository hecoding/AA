function plotError(sizes, Xtrain, ytrain, Xval, yval, num_hidden_neurons, num_labels, num_iter, lambda, normalization, scale = 'decimal')
% given a vector of sizes, this function trains a neural network for each one
% and computes the error of the prediction over the training and validation data
% then plots it. The examples of Xtrain and Xval must be row vectors.

if(strcmp(normalization, 'normalization'))
  save_name = 'error_norm.mat';
else
  save_name = 'error.mat';
end

if(exist(save_name, 'file') == 2)
  load(save_name);
else
  
  error_train = zeros(length(sizes),1);
  error_val = zeros(length(sizes),1);

  for i = 1:length(sizes)
    xsettrain = Xtrain(1:sizes(i),:);
    ysettrain = ytrain(1:sizes(i));
    
    [hits thetas] = runNN(xsettrain, ysettrain, num_hidden_neurons, num_labels, num_iter, lambda);
    
    [error_train(i) temp] = costNN(thetas, size(Xtrain,2), num_hidden_neurons, num_labels, xsettrain, ysettrain, lambda);
    [error_val(i) temp] = costNN(thetas, size(Xtrain,2), num_hidden_neurons, num_labels, Xval, yval, lambda);
  end
  save(save_name, 'error_train', 'error_val');
end

% filter NaNs to plot properly
for i = 1:length(error_train)
  if(isnan(error_train(i)) || isinf(error_train(i)))
    error_train(i) = 0;
  end
end

for i = 1:length(error_val)
  if(isnan(error_val(i)) || isinf(error_val(i)))
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