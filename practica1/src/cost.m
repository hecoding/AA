% parameters are row vectors of the same length
function J = cost(theta, X, y)
  m = length(y);
  
  J = ( theta * X' - y ).^2 / (2 * m);
  
endfunction