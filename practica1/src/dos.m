data = load('ex1data2.txt');
m = size(data, 1);
y = data(:, 3);
theta = [0 0 0];

[X mu sigma] = featureNormalize(data(:, 1:2));
X = [ones(m, 1), X];

num_iter = 1500;
[theta theta_hist] = gradientDesc(theta, X, y, 0.01, num_iter);

X = data(:, 1:2); % do not normalize
thetaNormal = pinv(X' * X) * X' * y;

prediction = [1650, 3];
resultadoGradiente = ( ([1, prediction] - [0 mu]) ./ [1 sigma] ) * theta'
resultadoNormal = prediction * thetaNormal
