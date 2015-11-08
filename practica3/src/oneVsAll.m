function [all_theta] = oneVsAll(X, y, num_etiquetas, lambda)
% ONEVSALL entrena varios clasificadores por regresión logística y devuelve
% el resultado en una matriz all_theta, donde la fila i-ésima
% corresponde al clasificador de la etiqueta i-ésima


% cosas por aqui

initial_theta = zeros(n + 1, 1);
options = optimset('GradObj','on','MaxIter',50);
% cosas por aqui
[theta] = fmincg (@(t)(lrCostFunction(t, X, (y == c), lambda)), initial_theta, options);
