function [J, grad] = lrCostFunction(theta, X, y, lambda)
% theta is a row vector
  m = length(y);
  
  J = (
        -sum( y .* log(sig(X * theta)) + (1 - y) .* log(1 - sig(X * theta)) )
       +
        lambda/2 * sum(theta .^ 2)
      ) / m;
      
  grad = (sum((sig(X * theta) - y) .* X) + lambda * theta') ./ m;
  grad = grad';
  
end