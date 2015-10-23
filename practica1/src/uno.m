data = load("ex1data1.txt");
m = size(data, 1);
X = [ones(m, 1), data(:,1)];
y = data(:, 2);
theta = zeros(1, 2);

theta = gradientDesc(theta, X, y, 0.01, 1500);