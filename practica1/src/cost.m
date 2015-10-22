function J = cost(theta, X, y)
  m = length(y);
  sumatory = 0;
  
  for i = 1:m;
    sumatory += ( h(theta, X(i, :)) - y(i) )^2;
  endfor
  
  J = 1/(2 * m) * sumatory;
  
endfunction