function theta = gradientDesc(theta, X, y, learning_rate, num_iter)
  m = length(y);
  
  for i = 1:num_iter;
    
    % if not in vector mode, theta components must be saved in temps
    % for not to crush them while doing the calculations until the end
    theta = theta - sum( (h(theta, X) - y) .* X ) * learning_rate / m;
    
  endfor

endfunction