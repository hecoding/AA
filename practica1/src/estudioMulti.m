function estudioMulti()
  data = load('ex1data2.txt');
  m = size(data, 1);
  y = data(:, 3);
  [X mu sigma] = featureNormalize(data(:, 1:2));
  X = [ones(m, 1), X];
  num_iter = 1500;
  
  theta = [0 0 0];
  [theta theta_hist] = gradientDesc(theta, X, y, 0.001, num_iter);
  
  temp = zeros(1, size(theta_hist, 1));
  for i = 1:size(theta_hist, 1)
    temp(i) = costMulti(theta_hist(i, :), X, y);
  endfor
  
  plot(1:100:num_iter, temp, ';\alpha = 0.0001;', 'color', 'blue');
  xlabel('# iterations', 'fontsize', 10);
  ylabel('J(\theta)', 'fontsize', 10);
  set(gca, "xlim", [0, num_iter]);
  hold on;
  
  theta = [0 0 0];
  [theta theta_hist] = gradientDesc(theta, X, y, 0.01, num_iter);
  
  temp = zeros(1, size(theta_hist, 1));
  for i = 1:size(theta_hist, 1)
    temp(i) = costMulti(theta_hist(i, :), X, y);
  endfor
  
  plot(1:100:num_iter, temp, ';\alpha = 0.01;', 'color', 'red');
  hold on;
  
  theta = [0 0 0];
  [theta theta_hist] = gradientDesc(theta, X, y, 0.1, num_iter);
  
  temp = zeros(1, size(theta_hist, 1));
  for i = 1:size(theta_hist, 1)
    temp(i) = costMulti(theta_hist(i, :), X, y);
  endfor
  
  plot(1:100:num_iter, temp, ';\alpha = 0.1;', 'color', 'magenta');
  hold on;
  
  theta = [0 0 0];
  [theta theta_hist] = gradientDesc(theta, X, y, 1, num_iter);
  
  temp = zeros(1, size(theta_hist, 1));
  for i = 1:size(theta_hist, 1)
    temp(i) = costMulti(theta_hist(i, :), X, y);
  endfor
  
  plot(1:100:num_iter, temp, ';\alpha = 1;', 'color', 'cyan');
  hold on;
  
  
  
  %equis = [1:10:num_iter];
  %ygriega = linspace(0.001, 1, length(equis));
  %[equis ygriega] = meshgrid(equis, ygriega);

  %zeta = cost([vec(equis) vec(ygriega)], X, y); ??
  %zeta = reshape(zeta, size(equis));


  %figure;
  %surface(equis, ygriega, zeta);
  %xlabel('# iterations', 'fontsize', 10);
  %ylabel('\alpha', 'fontsize', 10);
  %zlabel('J(\theta)', 'fontsize', 10);
  %view(-35, 30);
  %grid on;
  
endfunction