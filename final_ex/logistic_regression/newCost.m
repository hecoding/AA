function J = newCost(thetas, X, y, lambda)
% theta is a row vector
  m = length(y);
  J = 0;
  
  label = predict(X, thetas);
  
  theta = thetas(label,:)';

  J = sum(
        -sum( y .* log(sig(X * theta)) + (1 - y) .* log(1 - sig(X * theta)) )
       +
        lambda/2 * sum(theta .^ 2)
      ,2) / m;

  
end