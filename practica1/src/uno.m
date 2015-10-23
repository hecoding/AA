data = load('ex1data1.txt');
m = size(data, 1);
X = [ones(m, 1), data(:,1)];
y = data(:, 2);
theta = [0 0];

[theta theta_hist] = gradientDesc(theta, X, y, 0.01, 1500);

%plotting(theta, theta_hist y mas datos)
