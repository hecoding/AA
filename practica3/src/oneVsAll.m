function [all_theta] = oneVsAll(X, y, num_etiquetas, lambda)
% ONEVSALL entrena varios clasificadores por regresion logistica y devuelve
% el resultado en una matriz all_theta, donde la fila i-esima
% corresponde al clasificador de la etiqueta i-esima
% X ya tiene la fila de 1s

  all_theta = zeros(num_etiquetas, size(X,2));
  options = optimset('GradObj','on','MaxIter',50);

  for i = 1:num_etiquetas;
    initial_theta = all_theta(i, :)';

    [all_theta(i, :)] = fmincg (@(t)(lrCostFunction(t, X, (y == i), lambda)), initial_theta, options);
  end

end
