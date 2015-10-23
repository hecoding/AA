function J = cost(theta, X, y)
  m = length(y);
  
  J = sum(( h(theta, X) - y ) .^2) / (2 * m);
  
endfunction