function J = cost(theta, X, y)
  m = length(y);
  
  J = sum( 1/(2 * m) * ( h(theta, X) - y ) .^2 );
  
endfunction