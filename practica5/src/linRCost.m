function [J grad] = linRCost(X, y, theta, lambda)
m = length(y);
n = length(theta);

J = sum((X * theta - y) .^ 2) / (2 * m) + sum(theta(2:n) .^ 2) * lambda / (2 * m);

grad = X' * (X * theta - y) / m;
grad(2:n) = grad(2:n) + theta(2:n) * lambda / m; % regularization

end
