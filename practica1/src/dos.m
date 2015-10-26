data = load('ex1data2.txt');
m = size(data, 1);
X = [ones(m, 1), data(:, 1:2)];
y = data(:, 3);
theta = [0 0 0];

[X mu sigma] = normalizeAttrib(X);
X(:,1) = 1;

[theta theta_hist] = gradientDesc(theta, X, y, 0.01, 1500);

X = data(:, 1:2); % no se normaliza
thetaNormal = pinv(X' * X) * X' * y;

prediction = [1650, 3];
resultadoGradiente = ((prediction(1) - mu(2)) / sigma(2)) * theta(2) + ((prediction(2) - mu(3)) / sigma(3)) * theta(3) + theta(1)
resultadoNormal = thetaNormal(1) * prediction(1) + thetaNormal(2) * prediction(2)

%plottingMulti(X, y, theta, theta_hist);

% se normaliza y para el descenso de grad?
% los dos modelos se diferencian por 10000