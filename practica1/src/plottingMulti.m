function plotting(X, y, theta, theta_hist)

  %range = [5 23];5000, 5, 700000
  equis = linspace(1, 5000, 10)' * theta(1);
  ygriega = linspace(1, 5, 10)' * theta(2);
  zeta = linspace(1, 700000, 10)' * theta(3);
  plot3(data(:,1), data(:,2), data(:,3), 'r.', 'linewidth', 1, 'markersize', 8);
  hold on;
  plot3(equis, ygriega, zeta);
  %      range, range * theta(2) + theta(1));
  xlabel('x', 'fontsize', 10);
  ylabel('y', 'fontsize', 10);
  zlabel('z', 'fontsize', 10);
  
endfunction