warning('off', 'Octave:possible-matlab-short-circuit-operator');
load('ex5data1.mat');

m = length(y);
num_iter = 50;
lambda = 0;
poly_degree = 8;
theta = ones(poly_degree + 1, 1);
options = optimset('MaxIter', num_iter);


% we're training an overfitted model
[X_norm, mu, sigma] = featureNormalize(addFeatures(X, poly_degree));
X_norm = [ones(m,1) X_norm];

costFunction = @(temp_theta) linRCost(X_norm, y, temp_theta, lambda);
[theta, cost] = fmincg(costFunction, theta, options);

hold on;
plot(X, y, 'rx', 'linewidth', 2, 'markersize', 8);
plotFit(min(X), max(X), mu, sigma, theta, poly_degree);
hold off;

% now we evaluate the error over subsets of the data training
% and a cross validation set
error_set = zeros(length(1:m),1);
error_val = zeros(length(1:m),1);

Xv = Xval;
Xval = addFeatures(Xval, poly_degree);
Xval = bsxfun(@minus, Xval, mu);
Xval = bsxfun(@rdivide, Xval, sigma);
Xval = [ones(size(Xval, 1),1) Xval];

for i = 1:m
  xset = X_norm(1:i,:);
  yset = y(1:i);
  
  costFunction = @(temp_theta) linRCost(xset, yset, temp_theta, lambda);
  current_theta = fmincg(costFunction, theta, options);
  
  error_set(i) = linRCost(xset, yset, current_theta, lambda);
  error_val(i) = linRCost(Xval, yval, current_theta, lambda);
end

figure;
hold on;
plot(1:m, error_set);
plot(1:m, error_val, 'g');
xlabel('# training examples', 'fontsize', 10);
ylabel('Error', 'fontsize', 10);
legend('training', 'cross validation');
legend('boxoff');
title('\lambda = 0', 'fontsize', 12);
hold off;

figure;
hold on;
plot(Xv, yval, 'rx', 'linewidth', 2, 'markersize', 8);
plotFit(min(Xv), max(Xv), mu, sigma, current_theta, poly_degree);
title('function representation with cross validation data for \lambda = 0');
hold off;

% repeating the training with lambda = 1
lambda = 1;
for i = 1:m
  xset = X_norm(1:i,:);
  yset = y(1:i);
  
  costFunction = @(temp_theta) linRCost(xset, yset, temp_theta, lambda);
  current_theta = fmincg(costFunction, theta, options);
  
  error_set(i) = linRCost(xset, yset, current_theta, lambda);
  error_val(i) = linRCost(Xval, yval, current_theta, lambda);
end

figure;
hold on;
plot(1:m, error_set);
plot(1:m, error_val, 'g');
xlabel('# training examples', 'fontsize', 10);
ylabel('Error', 'fontsize', 10);
legend('training', 'cross validation');
legend('boxoff');
title('\lambda = 1', 'fontsize', 12);
hold off;

figure;
hold on;
plot(Xv, yval, 'rx', 'linewidth', 2, 'markersize', 8);
plotFit(min(Xv), max(Xv), mu, sigma, current_theta, poly_degree);
title('function representation with cross validation data for \lambda = 1');
hold off;

% repeating the training with lambda = 100
lambda = 100;
for i = 1:m
  xset = X_norm(1:i,:);
  yset = y(1:i);
  
  costFunction = @(temp_theta) linRCost(xset, yset, temp_theta, lambda);
  current_theta = fmincg(costFunction, theta, options);
  
  error_set(i) = linRCost(xset, yset, current_theta, lambda);
  error_val(i) = linRCost(Xval, yval, current_theta, lambda);
end

figure;
hold on;
plot(1:m, error_set);
plot(1:m, error_val, 'g');
xlabel('# training examples', 'fontsize', 10);
ylabel('Error', 'fontsize', 10);
legend('training', 'cross validation');
legend('boxoff');
title('\lambda = 100', 'fontsize', 12);
hold off;

figure;
hold on;
plot(Xv, yval, 'rx', 'linewidth', 2, 'markersize', 8);
plotFit(min(Xv), max(Xv), mu, sigma, current_theta, poly_degree);
title('function representation with cross validation data for \lambda = 100');
hold off;
