warning('off', 'Octave:possible-matlab-short-circuit-operator');
load('ex5data1.mat');

m = length(y);
theta = [1;1];
num_iter = 50;
lambda = 0;

options = optimset('MaxIter', num_iter);
costFunction = @(temp_theta) linRCost([ones(m,1) X], y, temp_theta, lambda);


[theta, cost] = fmincg(costFunction, theta, options);

hold on;
plot(X, y, 'rx', 'linewidth', 2, 'markersize', 8);
plot(X, [ones(m,1) X] * theta, 'b', 'linewidth', 2);
hold off;
