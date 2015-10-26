function J = cost(theta, X, y)
  m = length(y);
  
  J = sum(( X * theta' - y ) .^2) / (2 * m);
  
endfunction