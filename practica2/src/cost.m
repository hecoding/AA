function [J, grad] = cost(theta, X, y)
% theta is a row vector
  m = length(y);
  
  J = sum( y .* log(sig(X * theta')) + (1 - y) .* log(1 - sig(X * theta')) ) / -m;
  grad = sum((sig(X * theta') - y) .* X) ./ m;

end
