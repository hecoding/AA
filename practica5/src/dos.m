warning('off', 'Octave:possible-matlab-short-circuit-operator');
load('ex5data1.mat');

m = length(y);
theta = [1;1];
num_iter = 50;
lambda = 0;

options = optimset('MaxIter', num_iter);

error_set = zeros(length(1:m),1);
error_val = zeros(length(1:m),1);

for i = 1:m
  xset = [ones(length(1:i),1) X(1:i,:)];
  yset = y(1:i);
  
  costFunction = @(temp_theta) linRCost(xset, yset, temp_theta, lambda);
  current_theta = fmincg(costFunction, theta, options);
  
  error_set(i) = linRCost(xset, yset, current_theta, lambda);
  error_val(i) = linRCost([ones(length(yval),1) Xval], yval, current_theta, lambda);
end

hold on;
plot(1:m, error_set);
plot(1:m, error_val, 'g');
xlabel('# training examples', 'fontsize', 10);
ylabel('Error', 'fontsize', 10);
legend('training', 'cross validation');
legend('boxoff');
hold off;
