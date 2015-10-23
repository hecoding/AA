%function cost = J(theta0, theta1, data, m)
%  sumatory = 0;
%  xpos = 1:(size(data, 2) - 1);
%  ypos = size(data, 2);
%  
%  for i = 1:m;
%    sumatory += ( h([theta0 theta1], data(i, xpos)) - data(i, ypos) )^2;
%  endfor
%  
%  cost = 1/(2 * m) * sumatory;
%  
%endfunction
%
% parameters are row vectors of same length
%function hip = h(thetavector, x)
%  hip = thetavector * x';
%endfunction

%----------------------------------------

%function cost = J(theta0, theta1, data, m)
%  sumatory = 0;
%  xpos = 1:(size(data, 2) - 1);
%  ypos = size(data, 2);
%  
%  hache = h(theta0, theta1, data(:, xpos));
%  for i = 1:size(theta0,1);
%    %sumatory += ( hache - data(i, ypos) )^2;
%  endfor
%  cost = hache;
%  %cost = 1/(2 * m) * sumatory;
  
%endfunction

%-----------------------------------------

%function hip = h(theta0, theta1, x)
%  hip = zeros(size(theta0));
%  for j = 1:size(theta0, 1);
%    for k = 1:size(theta0, 2);
%      hip(j, k) = [theta0(j, k) theta1(j, k)] * x(j, :)';
%    endfor
%  endfor
%  %hip = [theta0 theta1] .* x';
%endfunction

%-----------------------------------------

%function theta = gradientDesc(theta, X, y, learning_rate, num_iter)
%  m = length(y);

%  for i = 1:num_iter;

%    % if not in vector mode, theta components must be saved in temps
%    % while doing the calculations
%    theta1 = theta(1) - sum( ((h(theta, X) - y) .^2) .* X(:,1) ) *
%learning_rate / m;
%    theta2 = theta(2) - sum( ((h(theta, X) - y) .^2) .* X(:,2) ) *
%learning_rate / m;

%    theta = [theta1 theta2];

%  endfor

%endfunction