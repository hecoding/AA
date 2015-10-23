function [theta theta_history] = gradientDesc(theta, X, y, learning_rate, num_iter)
  m = length(y);
  div = 100;
  theta_history = zeros(num_iter / div, 2);
  count = 1;
  
  for i = 1:num_iter;
    
    % if not in vector mode, theta components must be saved in temps
    % for not to crush them while doing the calculations until the end
    theta = theta - sum( (h(theta, X) - y) .* X ) * learning_rate / m;
    
    
    
    % saving at intervales of num_iter / div for plotting
    if (mod(i, div) == 0)
      theta_history(count, :) = theta;
      count++;
    endif
    
  endfor
endfunction