warning('off', 'Octave:possible-matlab-short-circuit-operator');
load('ex5data1.mat');

m = length(y);
num_iter = 50;
lambda_vec = [0, 0.001, 0.003, 0.01, 0.03, 0.1, 0.3, 1, 3, 10];
poly_degree = 8;
theta = ones(poly_degree + 1, 1);
options = optimset('MaxIter', num_iter);

% error vectors
error_set = zeros(length(lambda_vec),1);
error_val = zeros(length(lambda_vec),1);
error_test = zeros(length(lambda_vec),1);

% normalize all the data according to the data training set
[X_norm, mu, sigma] = featureNormalize(addFeatures(X, poly_degree));
X_norm = [ones(m,1) X_norm];

Xval_norm = addFeatures(Xval, poly_degree);
Xval_norm = bsxfun(@minus, Xval_norm, mu);
Xval_norm = bsxfun(@rdivide, Xval_norm, sigma);
Xval_norm = [ones(size(Xval_norm, 1),1) Xval_norm];

Xtest_norm = addFeatures(Xtest, poly_degree);
Xtest_norm = bsxfun(@minus, Xtest_norm, mu);
Xtest_norm = bsxfun(@rdivide, Xtest_norm, sigma);
Xtest_norm = [ones(size(Xtest_norm, 1),1) Xtest_norm];

% train for al the lambdas
for j = 1:length(lambda_vec)
  lambda = lambda_vec(j);
  for i = 1:m
    xset = X_norm(1:i,:);
    yset = y(1:i);
    
    costFunction = @(temp_theta) linRCost(xset, yset, temp_theta, lambda);
    current_theta = fmincg(costFunction, theta, options);
    
    err_s = linRCost(xset, yset, current_theta, lambda);
    err_v = linRCost(Xval_norm, yval, current_theta, lambda);
  end
  error_set(j) = err_s;
  error_val(j) = err_v;
end

figure;
hold on;
plot(lambda_vec, error_set);
plot(lambda_vec, error_val, 'g');
xlabel('\lambda', 'fontsize', 10);
ylabel('Error', 'fontsize', 10);
legend('training', 'cross validation');
legend('boxoff');
hold off;

%
for j = 1:length(lambda_vec)
  lambda = lambda_vec(j);
  for i = 1:m
    xset = X_norm(1:i,:);
    yset = y(1:i);
    
    costFunction = @(temp_theta) linRCost(xset, yset, temp_theta, lambda);
    current_theta = fmincg(costFunction, theta, options);
    
    err_s = linRCost(xset, yset, current_theta, lambda);
    err_v = linRCost(Xtest_norm, ytest, current_theta, lambda);
  end
  error_set(j) = err_s;
  error_val(j) = err_v;
end

figure;
hold on;
plot(lambda_vec, error_set);
plot(lambda_vec, error_val, 'c');
xlabel('\lambda', 'fontsize', 10);
ylabel('Error', 'fontsize', 10);
legend('training', 'test');
legend('boxoff');
hold off;
