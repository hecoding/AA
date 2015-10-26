function J = costMulti(theta, X, y)
  m = length(y);
  
  J = (X * theta' - y)' * (X * theta' - y) / (2 * m);
  
endfunction